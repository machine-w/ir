class Folder
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :description
  field :sort, :type => Integer, :default => 0

  belongs_to :user
  has_many :ducuments, :dependent => :destroy

  validates_presence_of :name
end
