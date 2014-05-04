class Group
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  mount_uploader :avatar, AvatarUploader
  field :description
  field :sort, :type => Integer, :default => 0
  field :has_home, :type => Boolean,:default => false
  has_many :group_messages, autosave: true
  embeds_many :group_members, cascade_callbacks: true
end
