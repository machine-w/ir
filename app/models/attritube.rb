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
		  		if val.blank? && property.req?
		  			"#{property.show_name}不可以为空字符串"
		  		elsif property.max_value && (val.length > property.max_value)
					"#{property.show_name}长度大于规定长度"
				elsif property.min_value && (val.length < property.min_value)
					"#{property.show_name}长度小于规定长度"
		  		else #缺少匹配字符串验证
		  			self.string_value= property.front_ext + val +property.back_ext
					''
		  		end
			when :integer #没有测试
				begin
					if val.blank? && property.req?
		  				"#{property.show_name}不可以为空"
		  			elsif ( property.max_value && val.to_i > property.max_value) ||
					   ( property.min_value && val.to_i < property.min_value)
					    "#{property.show_name}超出规定范围" 
					else
						self.int_value=val.to_i
						''
					end
				rescue
					"#{property.show_name}不可以转换为整数"
				end
			when :number #没有测试
				begin
					if val.blank? && property.req?
		  				"#{property.show_name}不可以为空"
		  			elsif ( property.max_value && val.to_f > property.max_value) ||
					   ( property.min_value && val.to_f < property.min_value)
					    "#{property.show_name}超出规定范围" 
					else
						self.float_value=val.to_f
						''
					end
				rescue
					"#{property.show_name}不可以转换为实数"
				end
			when :text #没有测试
				if val.blank? && property.req?
		  			"#{property.show_name}不可以为空字符串"
		  		elsif property.max_value && (val.length > property.max_value)
					"#{property.show_name}长度大于规定长度"
				elsif property.min_value && (val.length < property.min_value)
					"#{property.show_name}长度小于规定长度"
		  		else #缺少匹配字符串验证
		  			self.string_value = val
					''
		  		end
			when :embed_html
				if val.blank? && property.req?
		  			"#{property.show_name}不可以为空字符串"
		  		else #缺少匹配字符串验证
		  			self.string_value = val
					''
		  		end
			when :bool
				if val == 'on'
					self.bool_value = true
					''
				elsif val == 'off'
					self.bool_value = false
					''
				else
					"#{property.show_name}为非法字符"
				end
			when :enum
				if val.blank? && property.req?
		  			"#{property.show_name}不可以为空字符串"
		  		elsif property.enum_option && !val.blank? && !property.enum_option.include?(val)
					"#{property.show_name}只能选择已有选项"
		  		else #没有测试
		  			self.string_value = val
					''
		  		end
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
