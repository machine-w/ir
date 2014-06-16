class Folder
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :description
  field :sort, :type => Integer, :default => 0
  field :doc_count, :type => Integer, :default => 0
  field :markdown_or_html, :type => Boolean, :default => true #文章视图使用markdown还是富文本
  field :doc_default_content, :default => '' #目录文档的默认内容
  field :folder_item_view #目录在发布页面的中列表中每个item的内容

  field :tile, :type => Boolean, :default => false #是否显示到主页动态磁贴
  field :tile_color, :default => '#00c0ef'

  scope :has_tile, where(tile: true)
  default_scope asc(:created_at)

  belongs_to :user
  belongs_to :folder_type
  belongs_to :folder_group
  embeds_many :properties
  embeds_many :attritubes, cascade_callbacks: true
  embeds_one :permission, autobuild: true
  embeds_one :share_permission, :class_name => 'Permission', autobuild: true
  has_many :documents, :dependent => :destroy
  has_many :child_folders, :class_name => 'Folder', :inverse_of => :parent_folder
  belongs_to :parent_folder, :class_name => 'Folder', :inverse_of => :child_folders

  validates_presence_of :name
  before_save :set_permission
  before_save :set_default_property
  before_save do |folder|
    folder.tile = (folder.tile == "1") || (folder.tile == true) ? true : false
    true
  end
  # before_destroy do |folder|
  #   properties=folder.all_all_properties('')
  #   folder.child_folders.each do |f|  
  #     properties.each { |e| f.properties.push(e) } 
  #     logger.debug { f.properties.to_s }
  #     f.save
  #   end
  # end
  def allow_parent_edit?(folder)
    if self.parent_folder
      if self.parent_folder == folder
        true
      else
        self.parent_folder.allow_parent_edit?(folder)
      end
    else
      false
    end
  end
  def children_folder_documents(key,child=nil,one=nil)
    @all_docs = []
    self.child_folders.each do |f|
      next if !child.blank? && f._id.to_s != child
      if key.blank?
        @all_docs += f.documents.parent_visiable.entries
      else
        @all_docs += f.documents.parent_visiable.where(title: /.*#{key}.*/).entries
      end
      @all_docs += f.children_folder_documents(key) if f.child_folders.all.exists? && one.blank?
    end
    @all_docs
  end
  def tree_properties(key)
    properties=[]
    if key.blank?
      properties = self.properties.tree_all_property.entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_properties(key) + properties unless self.parent_folder.nil?
    else
      properties = self.properties.tree_all_property.where(name: /.*#{key}.*/).entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_properties(key) + properties unless self.parent_folder.nil?
    end
    properties
  end
  def tree_have_property?(p_name)
      if self.properties.where(name: p_name).exists?
        # logger.debug { "#{self.name}true" }
        # logger.debug { "#{p_name}" }
        return true
      elsif self.parent_folder.nil?
        # logger.debug { "#{self.name}false" }
        # logger.debug { "#{p_name}" }
        return false
      else  
        return self.parent_folder.tree_have_property?(p_name)
      end
  end
  def all_all_properties(key)
    properties=[]
    if key.blank?
      properties = self.properties.all.entries
      properties = self.parent_folder.tree_properties(key) + properties unless self.parent_folder.nil?
    else
      properties = self.properties.where(name: /.*#{key}.*/).entries
      properties = self.parent_folder.tree_properties(key) + properties unless self.parent_folder.nil?
    end
    properties
  end
  def tree_dynamic_properties
    properties=[]
      properties = self.properties.tree_public_property.enable_not_static.entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_dynamic_properties + properties unless self.parent_folder.nil?

    properties
  end
  def all_dynamic_properties
    properties=[]
    properties = self.properties.enable_not_static.entries
    #self.properties.each { |e| logger.debug { e.name } }
    properties = properties + self.parent_folder.tree_dynamic_properties  unless self.parent_folder.nil?
    properties
  end
  def tree_static_properties
    properties=[]
      properties = self.properties.tree_public_property.enable_static.entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_static_properties + properties unless self.parent_folder.nil?
    properties
  end
  def all_static_properties
    properties=[]
    properties = self.properties.enable_static.entries
    properties = properties + self.parent_folder.tree_static_properties  unless self.parent_folder.nil?
    properties
  end
  def tree_enable_properties
    properties=[]
      properties = self.properties.tree_all_property.enable_all.entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_enable_properties + properties unless self.parent_folder.nil?
    properties
  end
  def all_enable_properties
    properties=[]
    properties = self.properties.enable_all.entries
    properties = properties + self.parent_folder.tree_enable_properties  unless self.parent_folder.nil?
    properties
  end
  def tree_identify_properties
    properties=[]
      properties = self.properties.identify_property.entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_identify_properties + properties unless self.parent_folder.nil?
    properties
  end
  def all_identify_properties
    properties=[]
    properties = self.properties.identify_property.entries
    properties = properties + self.parent_folder.tree_identify_properties  unless self.parent_folder.nil?
    properties
  end
  #数据表中没有必要显示静态属性
  def tree_grid_show_properties
    properties=[]
      properties = self.properties.tree_all_property.grid_show.entries
      properties.each { |e| e.set_inherit }
      properties = self.parent_folder.tree_grid_show_properties + properties unless self.parent_folder.nil?
    properties
  end
  def all_grid_show_properties
    properties=[]
    properties = self.properties.grid_show.entries
    properties = properties + self.parent_folder.tree_grid_show_properties  unless self.parent_folder.nil?
    properties
  end
  def attr_value(property_name)
    if self.attritubes.where(property_name: property_name).exists?
      self.attritubes.where(property_name: property_name).first.get_value
    elsif self.parent_folder
        self.parent_folder.attr_value(property_name)
    else
      nil
    end
  end
  def content_attr_value(property_name,oper=nil,origin_doc=nil)
    if self.attritubes.where(property_name: property_name).exists?
      if oper.blank?
        self.attritubes.where(property_name: property_name).first.get_content_value(origin_doc)
      else
        self.attritubes.where(property_name: property_name).first.get_content_oper_value(oper,origin_doc)
      end
      
    elsif self.parent_folder
        self.parent_folder.content_attr_value(property_name,oper,origin_doc)
    else
      ''
    end
  end
  def visiable?(visitor)
    return true if self.user == visitor
    folder_permission = self.permission
    if folder_permission.inherit
      self.parent_folder.nil? ? false : self.parent_folder.visiable?(visitor)
    elsif folder_permission.privated
      false
    elsif folder_permission.all?
      true
    elsif folder_permission.user?
      visitor.nil? ? false : true
    elsif folder_permission.scope?
      if visitor.nil?
        false
      else
        folder_permission.permission_scopes.each do |scope| 
          return true if scope.visiable?(visitor,self.user)
        end
        false
      end
    end
  end
  def share_visiable?(visitor)
    return true if self.user == visitor
    folder_permission = self.share_permission
    if folder_permission.inherit
      self.parent_folder.nil? ? false : self.parent_folder.visiable?(visitor)
    elsif folder_permission.privated
      false
    elsif folder_permission.all?
      true
    elsif folder_permission.user?
      visitor.nil? ? false : true
    elsif folder_permission.scope?
      if visitor.nil?
        false
      else
        folder_permission.permission_scopes.each do |scope| 
          return true if scope.visiable?(visitor,self.user)
        end
        false
      end
    end
  end
  def set_dirty_all_documents
    self.documents.each { |e| e.set_dirty_flag } #目录中全部文档治脏。
    self.child_folders.each do |f|  
      f.set_dirty_all_documents
    end
  end
  def get_original_content
    if self.doc_default_content.gsub(/\&nbsp;/, '').strip.blank? && self.parent_folder
       self.parent_folder.get_original_content
    else
      self.doc_default_content
    end
  end
  protected
  def set_permission
    if self.new_record?
      self.build_share_permission({inherit: false,privated: true})
      unless self.parent_folder.nil?
        self.build_permission({inherit: true})
      else
        case self.folder_type.list_view
        when :thesis,:book,:patent
          self.build_permission({inherit: false,privated: false,public_type: :user})
        when :note, :picture,:video, :music,:file,:data
          self.build_permission({inherit: false,privated: true}) 
        when :blog,
          self.build_permission({inherit: false,privated: false,public_type: :all})
        end
      end
    end
    true
  end
  def set_default_property
    if self.new_record?
      if self.parent_folder.nil?
        case self.folder_type.list_view
        when :picture
          self.properties.build({name: 'default',show_name: '预设图片', description: '建立图片目录自动添加的图片属性', type_cd: 10,require: true})
          self.doc_default_content = %Q{&nbsp;<button pid="default" type="button" class="btn btn-info btn-sm is-a-property " oper="origin" data-toggle="tooltip" data-placement="top" title="预设图片-原始大小"><i class="fa fa-picture-o"></i></button>&nbsp;}
        when :video
          self.properties.build({name: 'default',show_name: '预设视频', description: '建立视频目录自动添加的视频属性', type_cd: 11,require: true})
          self.doc_default_content = %Q{&nbsp;<button pid="default" type="button" class="btn btn-info btn-sm is-a-property " oper="origin" data-toggle="tooltip" data-placement="top" title="预设视频-原始播放"><i class="fa fa-video-camera"></i></button>&nbsp;}
        when :music
          self.properties.build({name: 'default',show_name: '预设音乐', description: '建立音乐目录自动添加的音乐属性', type_cd: 12,require: true})
          self.doc_default_content = %Q{&nbsp;<button pid="default" type="button" class="btn btn-info btn-sm is-a-property " oper="play" data-toggle="tooltip" data-placement="top" title="预设音乐-嵌入播放"><i class="fa fa-music"></i></button>&nbsp;}
        when :file
          self.properties.build({name: 'default',show_name: '预设文件', description: '建立文件目录自动添加的文件属性', type_cd: 8,require: true})
          self.doc_default_content = %Q{&nbsp;<button pid="default" type="button" class="btn btn-danger btn-sm is-a-property " data-toggle="tooltip" data-placement="top" title="预设文件"><i class="fa fa-file"></i></button>&nbsp;}
        end
      end
    end
    true
  end
end
