class NotificationType
  include Mongoid::Document
  include SimpleEnum::Mongoid
	field :name
	field :description
	field :sort, :type => Integer, :default => 0
	field :image_path
	as_enum :type_name, :thesis => 1,:book => 2, :patent => 3, 
	        			:blog => 4,  :note => 5, :picture => 6,:video => 7, :music => 8, :file => 9,:data => 10

	has_many :notifications
	validates_presence_of :name,:type_name,:image_path
end
