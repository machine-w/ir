class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::ByStar
  include TruncateHtmlHelper
  require 'nokogiri'
  field :title
  field :summary
  field :content_have_attr
  field :content_html
  field :content_html_summary
  field :dirty_flag, :type => Boolean , :default => false #判断是否有属性被修改，如果被修改，则看内容时需要重新编译
  field :sort, :type => Integer, :default => 0

  default_scope desc(:created_at)

  # scope :browse, ->(visitor) do  
  #   result = []
  #   where(name: name).each do  |e|  
  #     result.push e if e.visiable?(visitor)
  #   end
  #   result
  # end

  belongs_to :folder
  has_and_belongs_to_many :third_disciplines
  has_and_belongs_to_many :tags
  embeds_many :attritubes, cascade_callbacks: true
  embeds_one :permission, autobuild: true
  validates_presence_of :title

  #保存前确定是新文档还是文档更新
  before_save :set_newdoc_flag
  before_save :fill_content_with_property
  before_save :fill_content_summary
  #如果是新建文档，则增加目录文档数
  after_save :increase_folder_count, :if => "@was_a_new_record"
  #删除文档后，减少目录文档数
  after_destroy :decrease_folder_count
  after_destroy :destroy_relation_message


  def all_dynamic_properties
    self.folder.properties.enable_not_static
  end
  def all_properties
    self.folder.properties.enable_all
  end
  def all_identify_properties
    self.folder.properties.identify_property
  end
  #暂时只返回填入的内容
  def get_content
    if self.dirty_flag
      clean_content
    end
    self.content_html
  end
  def get_summary_content
    if self.dirty_flag
      clean_content
    end
    self.content_html_summary
  end
  def get_original_content
    if self.content_have_attr.gsub(/\&nbsp;/, '').strip.blank?
      self.folder.doc_default_content
    else
      self.content_have_attr
    end
  end
  def notice_content?
    case self.folder.folder_type.list_view
    when :thesis,:book,:patent,:picture,:video,:music,:file,:data
      false
    when :blog,:note
      true
    end
  end
  def notice_property?
    case self.folder.folder_type.list_view
    when :thesis,:book,:patent,:picture,:video,:music,:file,:data
      true
    when :blog,:note
      false
    end
  end
  def attr_value(property_name)
    if self.attritubes.where(property_name: property_name).exists?
      self.attritubes.where(property_name: property_name).first.get_value
    else
      nil
    end
  end
  def table_attr_value(property_name)
    if self.attritubes.where(property_name: property_name).exists?
      self.attritubes.where(property_name: property_name).first.get_table_value
    else
      ''
    end
  end
  def content_attr_value(property_name)
    if self.attritubes.where(property_name: property_name).exists?
      self.attritubes.where(property_name: property_name).first.get_content_value
    else
      ''
    end
  end
  def set_dirty_flag
    self.update_attribute(:dirty_flag, true)
  end
  def visiable?(visitor,listorsearch = true)
    doc_permission = self.permission
    return true if self.folder.user == visitor
    if doc_permission.inherit
      self.folder.visiable?(visitor)
    elsif doc_permission.privated
      false
    elsif listorsearch && doc_permission.list_search_visiable == false
      false
    elsif doc_permission.all?
      true
    elsif doc_permission.user?
      visitor.nil? ? false : true
    elsif doc_permission.scope?
      if visitor.nil?
        false
      else
        doc_permission.permission_scopes.each do |scope| 
          return true if scope.visiable?(visitor,self.folder.user)
        end
        false
      end
    end
  end


  private


  def set_newdoc_flag
    @was_a_new_record = new_record?
    return true
  end
  def increase_folder_count
    #logger.info "add count"
    self.folder.update_attribute(:doc_count, self.folder.doc_count + 1 )
  end
  def decrease_folder_count
    self.folder.update_attribute(:doc_count, self.folder.doc_count - 1 )
  end
  def fill_content_with_property
    self.content_html=fill_properties(self.get_original_content)
    self.dirty_flag=false
    true
  end
  def fill_content_summary
    self.content_html_summary=truncate_html(self.content_html)
    true
  end
  def fill_properties(original_content)
    doc = Nokogiri::HTML original_content
    doc.css('.is-a-property').each do |p|
      if p['class'].include?('is-static')
        p.replace  self.folder.content_attr_value(p["id"])
      else
        p.replace  self.content_attr_value(p["id"])
      end
    end
    doc.css('#summary_line').each do |p|
      p.replace  '<!-- truncate -->'
    end
    doc.to_html
  end
  def clean_content
    self.update_attribute(:content_html, fill_properties(self.get_original_content))
    self.update_attribute(:content_html_summary,truncate_html(self.content_html))
    self.dirty_flag=false
  end

  def destroy_relation_message
    Message.where(add_document: self).destroy
    GroupMessage.where(add_document: self).destroy
  end

end
