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
end
