class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  belongs_to :from, class_name: "User", inverse_of: nil
  belongs_to :add_document, class_name: "Document", inverse_of: nil
  field :content
  field :unread, :type => Boolean,:default => true 
  #embedded_in :conversation
  belongs_to :conversation
end
