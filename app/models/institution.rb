class Institution
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :description
  field :sort, :type => Integer, :default => 0
  has_many :departments, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name


  default_scope desc(:sort)
end
