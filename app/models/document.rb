class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :title
  field :summary
  field :content_have_attr
  field :content_html
  field :dirty_flag, :type => Boolean , :default => false #判断是否有属性被修改，如果被修改，则看内容时需要重新编译
  field :sort, :type => Integer, :default => 0

  belongs_to :folder
  has_and_belongs_to_many :third_disciplines
  has_and_belongs_to_many :tags
  embeds_many :attritubes, cascade_callbacks: true

  validates_presence_of :title

  #保存前确定是新文档还是文档更新
  before_save :set_newdoc_flag
  #如果是新建文档，则增加目录文档数
  after_save :increase_folder_count, :if => "@was_a_new_record"
  #删除文档后，减少目录文档数
  after_destroy :decrease_folder_count
  def all_properties
    self.folder.properties.enable_not_static
  end
  #暂时只返回填入的内容
  def get_content
    self.content_have_attr
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
    #logger.info "add count"
    self.folder.update_attribute(:doc_count, self.folder.doc_count - 1 )
  end
end
