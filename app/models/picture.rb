class Picture
  include Mongoid::Document
  field :image_url
  field :name
  validates_presence_of :name,:image_url
  #has_many :backpictures, :dependent => :destroy
  
end
