class PropertyOper
  include Mongoid::Document
  
	field :name
	field :description
	field :sort, :type => Integer, :default => 0
	field :function_name
	field :function_context


	embedded_in :property_type

	validates_presence_of :name,:function_name,:function_context
end
