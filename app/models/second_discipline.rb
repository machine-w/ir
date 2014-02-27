class SecondDiscipline
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :code
  field :description
  field :sort, :type => Integer, :default => 0
  
  has_many :third_disciplines
  belongs_to :first_discipline
  
  validates_presence_of :name,:code
  validates_uniqueness_of :name,:code

  default_scope desc(:sort)
end
