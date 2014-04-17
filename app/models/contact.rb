class Contact
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :email
  field :not_exist_user, :type => Boolean, :default => false
  field :description
  field :sort, :type => Integer, :default => 0

  belongs_to :user
  belongs_to :firend, class_name: "User", inverse_of: :contacted

  validates_presence_of :user_id, :firend_id
end
