class Attritube
	include Mongoid::Document
	include SimpleEnum::Mongoid
	include ActionView::Helpers::TextHelper
	field :property_id, :type => Moped::BSON::ObjectId
	field :property_name
  #属性类型
  as_enum :type, :string => 1, :text => 2, :integer => 3, :number => 4, 
  :embed_html => 5, :enum => 6, :muli_enum  => 7, :file => 8, 
  :pdf => 9, :picture => 10, :video => 11, :music => 12, 
  :time => 13, :date =>14, :data_sheet => 15, :array => 16,:email => 17,:link => 18,:bool => 19
  field :string_value
  field :float_value, :type => Float
  field :int_value, :type => Integer
  field :bool_value, :type => Boolean
  field :array_value, :type => Array
  field :data_value, :type => Date
  field :time_value, :type => Time

  embedded_in :document

  def save_value(property,val)
  	msg=''
  	msg =  case property.type
		  	when :string 
		  		self.string_value=val
		  		''
			when :integer 
				self.int_value=val.to_i
				''
			when :number 
				self.float_value=val.to_f
				''
			when :text 
				self.string_value=val
				''
			when :embed_html 
				self.string_value=val
			when :bool
				self.string_value=val
			when :enum
				self.string_value=val
			when :muli_enum
				self.string_value=val
			when :array 
				self.string_value=val
			when :email
				self.string_value=val
			when :file 
				self.string_value=val
			when :pdf
				self.string_value=val
			when :picture
				self.string_value=val
			when :video
				self.string_value=val
			when :music
				self.string_value=val
			when :date
				self.string_value=val
			when :time
				self.string_value=val
			when :link 
				self.string_value=val
			when :data_sheet 
				self.string_value=val
			else
				"不支持的字段类型" 		
		  	end
  	return msg
  end
  def get_value
  	
  end
end
