class Backpicture
  include Mongoid::Document
  include SimpleEnum::Mongoid
  
  field :image_url
  as_enum :type, :system => 1, :custom => 2
  embedded_in :user
  belongs_to :picture
end
