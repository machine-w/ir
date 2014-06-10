class Attritube
	include Mongoid::Document
	include SimpleEnum::Mongoid
	include ActionView::Helpers::TextHelper
	include ActionView::Helpers::UrlHelper
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
  field :date_value, :type => Date
  field :time_value, :type => Time
  mount_uploader :file_value, FileUploader

  embedded_in :document
  embedded_in :folder

  def save_value(property,val)
  	msg=''
  	msg =  case property.type
		  	when :string,:email,:link
		  		if val.blank?
		  			property.req? ? "#{property.show_name}不可以为空字符串;" : self.string_value=''
		  		elsif property.max_value && (val.length > property.max_value)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.length < property.min_value)
					"#{property.show_name}长度小于规定长度;"
		  		else #缺少匹配字符串验证
		  			self.string_value= val
					''
		  		end
			when :integer #没有测试
				begin
					if val.blank?
		  				property.req? ? "#{property.show_name}不可以为空;" : ''
		  			elsif ( property.max_value && val.to_i > property.max_value) ||
					   ( property.min_value && val.to_i < property.min_value)
					    "#{property.show_name}超出规定范围;" 
					else
						self.int_value=val.to_i
						''
					end
				rescue
					"#{property.show_name}不可以转换为整数;"
				end
			when :number #没有测试
				begin
					if val.blank?
		  				property.req? ? "#{property.show_name}不可以为空;" : ''
		  			elsif ( property.max_value && val.to_f > property.max_value) ||
					   ( property.min_value && val.to_f < property.min_value)
					    "#{property.show_name}超出规定范围;" 
					else
						self.float_value=val.to_f
						''
					end
				rescue
					"#{property.show_name}不可以转换为实数;"
				end
			when :text #没有测试
				if val.blank?
		  			property.req? ? "#{property.show_name}不可以为空字符串;" : ''
		  		elsif property.max_value && (val.length > property.max_value)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.length < property.min_value)
					"#{property.show_name}长度小于规定长度;"
		  		else #缺少匹配字符串验证
		  			self.string_value = val
					''
		  		end
			when :embed_html
				if val.blank?
		  			property.req? ? "#{property.show_name}不可以为空字符串;" : ''
		  		else #缺少匹配字符串验证
		  			self.string_value = val
					''
		  		end
			when :bool
				if val == 'on' || val == true
					self.bool_value = true
					''
				elsif val == 'off' || val == false
					self.bool_value = false
					''
				else
					"#{property.show_name}为非法字符;"
				end
			when :enum
				if val.blank?
					if property.req?
						"#{property.show_name}不可以为空字符串;"
					else
						self.string_value = val
						''
					end
		  			#property.req? ? "#{property.show_name}不可以为空字符串;" : ''
		  		elsif !property.enum_option.empty? && !property.enum_option.include?(val)
					"#{property.show_name}只能选择已有选项;"
		  		else #没有测试
		  			self.string_value = val
					''
		  		end
			when :muli_enum
				if val.empty?
					if property.req?
						"#{property.show_name}不可以为空字符串;"
					else
						self.array_value = val
						''
					end
		  			#property.req? ? "#{property.show_name}不可以为空字符串;" : ''
		  		elsif !property.enum_option.empty? && (property.enum_option & val) != val
					"#{property.show_name}只能选择已有选项;"
		  		else #没有测试
		  			self.array_value = val
					''
		  		end
			when :array
				if val.blank?
		  			property.req? ? "#{property.show_name}不可以为空;" : ''
		  		else #没有测试
		  			self.array_value = val.split(',')
					''
		  		end
			when :file
				if property.max_value && (val.size > property.max_value * 1048576)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.size < property.min_value * 1048576)
					"#{property.show_name}长度小于规定长度;"
				elsif !property.file_type.empty? && !property.file_type.include?(val.original_filename[1+(val.original_filename.rindex('.') || -2) ..-1])
					#logger.info val.original_filename[/\.(.*)$/]
					"#{property.show_name}文件类型不合法;"
		  		else #缺少匹配字符串验证
		  			self.file_value = val
		  			self.string_value = val.original_filename
					''
		  		end
				# logger.info val.size
				# logger.info val.content_type
				# logger.info val.path
				# logger.info val.original_filename	
			when :pdf
				if property.max_value && (val.size > property.max_value * 1048576)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.size < property.min_value * 1048576)
					"#{property.show_name}长度小于规定长度;"
		  		else #缺少匹配字符串验证
		  			self.file_value = val
		  			self.string_value = val.original_filename
					''
		  		end
			when :picture
				if property.max_value && (val.size > property.max_value * 1048576)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.size < property.min_value * 1048576)
					"#{property.show_name}长度小于规定长度;"
		  		else #缺少匹配字符串验证
		  			self.file_value = val
		  			self.string_value = val.original_filename
					''
		  		end
			when :video
				if property.max_value && (val.size > property.max_value * 1048576)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.size < property.min_value * 1048576)
					"#{property.show_name}长度小于规定长度;"
		  		else #缺少匹配字符串验证
		  			self.file_value = val
		  			self.string_value = val.original_filename
					''
		  		end
			when :music
				if property.max_value && (val.size > property.max_value * 1048576)
					"#{property.show_name}长度大于规定长度;"
				elsif property.min_value && (val.size < property.min_value * 1048576)
					"#{property.show_name}长度小于规定长度;"
		  		else #缺少匹配字符串验证
		  			self.file_value = val
		  			self.string_value = val.original_filename
					''
		  		end
			when :date
				if val.blank?
		  			property.req? ? "#{property.show_name}不可以为空字符串;" : ''
		  		else
		  			begin
		  				self.date_value=Date.strptime(val, "%Y年%m月%d日")
						''
		  			rescue
					"#{property.show_name}日期格式错误;"
		  			end
		  		end
			when :time
				if val.blank?
					property.req? ? "#{property.show_name}不可以为空字符串;" : ''
		  		else
		  			begin
		  				self.time_value=Time.strptime(val, "%I:%M %p")
		  				''
		  			rescue
		  				"#{property.show_name}时间格式错误;"
		  			end
		  		end
			when :data_sheet 
				if val.delete(",").blank?
		  			property.req? ? "#{property.show_name}不可以为空;" : ''
		  		else #没有测试
		  			self.array_value = val.split(',')
		  			self.int_value = property.data_y
		  			self.float_value = property.data_x.to_f
					''
		  		end
			else
				"不支持的字段类型" 		
		  	end
  	return msg
  end
  def get_value
  	case self.type
  	when :string,:email,:link,:text,:enum
  		self.string_value || ''
  	when :integer
  		self.int_value
  	when :number
  		self.float_value
  	when :embed_html
  		self.string_value.blank? ? '' : self.string_value.html_safe
	when :bool
		self.bool_value
	when :muli_enum,:array,:data_sheet
		self.array_value
	when :file,:picture,:video,:music,:pdf
		#{}"<a href='#{self.file_value.url}'><i class='fa fa-file'></i></a>"
		self.string_value.blank? ? nil : [self.string_value,self.file_value]
	when :date
		self.date_value
	when :time
		self.time_value
	else
	    nil					  		
  	end
  end
  def get_table_value
  	case self.type
  	when :string,:text
		truncate(self.string_value, :length => 10)
  	when :link
  		link_to truncate(self.string_value, :length => 10),"http://#{self.string_value}"
  		#"<a href ='http://#{self.string_value}'>#{truncate(self.string_value, :length => 10)}</a>".html_safe
  	when :email
  		mail_to self.string_value,truncate(self.string_value, :length => 10)
  		#"<a href ='mailto:#{self.string_value}'>#{truncate(self.string_value, :length => 10)}</a>".html_safe
  	when :integer
  		self.int_value.to_s
  	when :number
  		self.float_value.to_s
  	when :embed_html
  		truncate(strip_tags(self.string_value), :length => 10)
	when :bool
		self.bool_value ? '是' : '否'
	when :enum
		"<span class='label label-success'>#{truncate(self.string_value, :length => 10)}</span> ".html_safe
	when :muli_enum,:array
		result=''
		self.array_value.each{ |a| result += "<span class='label label-success'>#{truncate(a, :length => 10)}</span> " } unless self.array_value.nil?
		result.html_safe
	when :data_sheet
		"数据表（#{self.array_value.size}）" unless self.array_value.nil?
	when :file
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-file'></i></button></a>".html_safe
	when :picture
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-picture-o'></i></button></a>".html_safe
	when :video
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-video-camera'></i></button></a>".html_safe
	when :music
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-music'></i></button></a>".html_safe
	when :pdf
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-file-text'></i></button></a>".html_safe
	when :date
		self.date_value.strftime("%Y年%m月%d日") unless self.date_value.nil?
	when :time
		self.time_value.strftime("%I:%M %p") unless self.time_value.nil?				  		
  	end
  end
  def get_content_value
  	case self.type
  	when :string,:text,:enum
		self.string_value || ''
  	when :link
  		link_to self.string_value,"http://#{self.string_value}"
  		#"<a href ='http://#{self.string_value}'>#{truncate(self.string_value, :length => 10)}</a>".html_safe
  	when :email
  		mail_to self.string_value,self.string_value
  		#"<a href ='mailto:#{self.string_value}'>#{truncate(self.string_value, :length => 10)}</a>".html_safe
  	when :integer
  		self.int_value.to_s
  	when :number
  		self.float_value.to_s
  	when :embed_html
  		self.string_value.html_safe
	when :bool
		self.bool_value ? '是' : '否'
	# when :enum
	# 	"<span class='label label-success'>#{truncate(self.string_value, :length => 10)}</span> ".html_safe
	when :muli_enum,:array
		result=''
		self.array_value.each{ |a| result += "<span class='label label-success'>#{a}</span> " } unless self.array_value.nil?
		result.html_safe
	when :data_sheet
		#{}"数据表（#{self.array_value.size}）" unless self.array_value.nil?
		"<p><div class='handsontable-view'></div><input type='hidden' value='#{self.int_value}'/><input type='hidden' value='#{self.float_value.to_i}'/><input type='hidden' value='#{self.array_value || '[]'}'/></p>"
	when :file
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-file'></i>#{self.string_value}</button></a>".html_safe
	when :picture
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-picture-o'></i>#{self.string_value}</button></a>".html_safe
	when :video
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-video-camera'></i>#{self.string_value}</button></a>".html_safe
	when :music
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-music'></i>#{self.string_value}</button></a>".html_safe
	when :pdf
		"<a href='#{self.file_value}'><button type='button' title='#{self.string_value}' class='btn btn-info'><i class='fa fa-file-text'></i>#{self.string_value}</button></a>".html_safe
	when :date
		self.date_value.strftime("%Y年%m月%d日") unless self.date_value.nil?
	when :time
		self.time_value.strftime("%I:%M %p") unless self.time_value.nil?				  		
  	end
  end
  private
  # def div_arr(arr, div_len)  
  # 	if div_len <= 0 or div_len == 1 or div_len >= arr.size  
  # 		return [arr]  
  # 	end  
  # 	res = []  
  # 	arr.each_index{ |i|  
  # 		x,y = i / div_len,i % div_len  
  # 		res[x] = [] if not res[x]  
  # 		res[x][y] = arr[i]  
  # 	}
  # 	res  
  # end  
end
