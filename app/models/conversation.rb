class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  embeds_many :messages
  has_and_belongs_to_many :users
end
