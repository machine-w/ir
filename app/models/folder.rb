class Folder
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :description
  field :sort, :type => Integer, :default => 0
  field :doc_count, :type => Integer, :default => 0
  field :markdown_or_html, :type => Boolean, :default => true #文章视图使用markdown还是富文本
  field :doc_default_content #目录文档的默认内容
  field :folder_item_view #目录在发布页面的中列表中每个item的内容

  field :tile, :type => Boolean, :default => false #是否显示到主页动态磁贴
  field :tile_color, :default => '#00c0ef'

  scope :has_tile, where(tile: true)

  belongs_to :user
  belongs_to :folder_type
  belongs_to :folder_group
  embeds_many :properties
  has_many :documents, :dependent => :destroy

  validates_presence_of :name

  before_save do |folder|
    folder.tile = (folder.tile == "1") ? true : false
    true
  end
  def all_dynamic_properties
    self.properties.enable_not_static
  end
  def all_properties
    self.properties.enable_all
  end
  def all_identify_properties
    self.properties.identify_property
  end
  def all_grid_show_properties
    self.properties.grid_show
  end
end
