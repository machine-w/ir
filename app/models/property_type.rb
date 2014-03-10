class PropertyType
	include Mongoid::Document
	include SimpleEnum::Mongoid
	field :name
	field :description
	field :sort, :type => Integer, :default => 0
	field :image_path
	as_enum :type_view, :string => 1, :text => 2, :integer => 3, :number => 4, 
	:embed_html => 5, :enum => 6, :muli_enum  => 7, :file => 8, 
	:pdf => 9, :picture => 10, :video => 11, :music => 12, 
	:time => 13, :date =>14 , :data_sheet => 15, :array => 16,:email => 17,:link => 18,:bool => 19
	field :user_can_select, :type => Boolean, :default => true

	embeds_many :property_opers

	validates_presence_of :name,:type_view,:image_path,:user_can_select
end
