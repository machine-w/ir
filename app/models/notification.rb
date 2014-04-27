class Notification
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :title
  field :content
  field :unread, :type => Boolean,:default => true 

  belongs_to :add_document, class_name: "Document", inverse_of: nil
  belongs_to :notification_type
  belongs_to :user
end
