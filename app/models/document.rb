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
end
