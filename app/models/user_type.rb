class UserType
	include Mongoid::Document
	include SimpleEnum::Mongoid
	field :name
	field :description
	field :sort, :type => Integer, :default => 0
	field :image_path
	field :user_can_select, :type => Boolean, :default => true
	has_many :users
	validates_presence_of :name,:image_path,:user_can_select
end
