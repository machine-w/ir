class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :description
  field :sort, :type => Integer, :default => 0
  field :users_count, :type => Integer, :default => 0

  has_many :users, dependent: :nullify
  belongs_to :institution

  validates_presence_of :name, :institution
  validates_uniqueness_of :name

  scope :hots, desc(:users_count)
  scope :sorted, desc(:sort)
end
