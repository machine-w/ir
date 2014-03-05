class FolderType
  	include Mongoid::Document
	include SimpleEnum::Mongoid
	field :name
	field :description
	field :sort, :type => Integer, :default => 0
	field :image_path
	as_enum :list_view, :thesis => 1,:book => 2, :patent => 3, 
	        			:blog => 4,  :note => 5, :picture => 6,:video => 7, :music => 8, :file => 9,:data => 10
	field :user_can_select, :type => Boolean, :default => true

	has_many :folders
	validates_presence_of :name,:list_view,:image_path,:user_can_select
end
