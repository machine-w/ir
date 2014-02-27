class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :description
  field :sort, :type => Integer, :default => 0
  field :documents_count, :type => Integer, :default => 0

  has_and_belongs_to_many :documents

  scope :hots, desc(:documents_count)
  default_scope desc(:sort)
end
