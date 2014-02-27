class ThirdDiscipline
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :code
  field :description
  field :sort, :type => Integer, :default => 0
  field :users_count, :type => Integer, :default => 0
  field :documents_count, :type => Integer, :default => 0
  
  belongs_to :second_discipline
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ducuments
  
  validates_presence_of :name,:code
  validates_uniqueness_of :name,:code

  default_scope desc(:sort)
  scope :user_hots, desc(:users_count)
  scope :document_hots, desc(:documents_count)
end
