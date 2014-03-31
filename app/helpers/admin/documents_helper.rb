module Admin::DocumentsHelper
	def get_property_form_view(property)
		label = "<label for='#{property._id}' class='control-label'>#{property.show_name.blank? ? property.name : property.show_name}: </label>"
		req = "check-type='required' required-message='#{property.show_name}为必填字段'" if property.req? || ((property.string? || property.text?) && property.have_min?)
		req_num = "check-type='#{'required ' if property.req? }number' required-message='#{property.show_name}为必填字段'"
		req_mail = "check-type='#{'required ' if property.req? }mail' required-message='#{property.show_name}为必填字段'"
		maxlength = "maxlength = '#{property.max_value}' " if property.have_max?
		minlength = "minlength = '#{property.min_value}' " if property.have_min?
		num_range = "range='#{property.have_min? ? property.min_value : 'min'}~#{property.have_max? ? property.max_value : 'max'}'"
		front = "<span class='input-group-addon'>#{property.front_ext}</span>" if property.have_front?
		back = "<span class='input-group-addon'>#{property.back_ext}</span>" if property.have_back?
		input = case property.type
					when :string #格式字符串没有做客户端验证
						"#{front}<input type='text' #{req} #{maxlength} #{minlength} name='properties[#{property.name}]' class='form-control' id='#{property._id}' placeholder='#{property.description}...'/> #{back}"
					when :integer 
						"#{front}<input type='text' #{req_num} #{num_range} name='properties[#{property.name}]' class='form-control inputnumber' id='#{property._id}' placeholder='#{property.description}...'/> #{back}"
					when :number 
						"#{front}<input type='text' #{req_num} #{num_range} name='properties[#{property.name}]' class='form-control inputdecimal' id='#{property._id}' placeholder='#{property.description}...'/> #{back}"
					when :text 
						"<textarea type='text' rows='6' #{req} #{maxlength} #{minlength} name='properties[#{property.name}]' class='form-control' id='#{property._id}' placeholder='#{property.description}...'></textarea>"
					when :embed_html #必填属性客户端不验证
						"<input type='text' name='properties[#{property.name}]' class='form-control summernote-input' id='#{property._id}' placeholder='#{property.description}...'/>"
					when :bool
						"<input type='checkbox' #{"checked='checked'" if property.req?} name='properties[#{property.name}]' class='switch switch-small' data-on='primary' data-off='default' data-on-label='是' data-off-label='否' />"
					when :enum
						options = property.req? ? property.enum_option.map { |i| [i,i]  } : property.enum_option.map { |i| [i,i]  }.unshift(['',''])
						select_tag("properties[#{property.name}]", options_for_select(options),{id: property._id, class: "form-control select2",placeholder:"#{property.description}..."})
					when :muli_enum
						options = property.req? ? options_for_select(property.enum_option.map { |i| [i,i]  },property.enum_option) : 
												  options_for_select(property.enum_option.map { |i| [i,i]  })
						select_tag("properties[#{property.name}]", options,{id: property._id, class: "form-control select2",multiple: true,placeholder:"#{property.description}..."})
					when :array #客户端验证没有做
						"<input type='text' name='properties[#{property.name}]' class='form-control tm-input tm-input-success tm-input-small tags' id='#{property._id}' placeholder='#{property.description}...'/>"
					when :email
						"<input type='text' #{req_mail} name='properties[#{property.name}]' class='form-control' id='#{property._id}' placeholder='#{property.description}...'/>"
					when :file #客户端验证没有做
						file_field_tag "properties[#{property.name}]", id: property._id
					when :pdf
						file_field_tag "properties[#{property.name}]", id: property._id, accept: 'application/pdf'
					when :picture
						file_field_tag "properties[#{property.name}]", id: property._id, accept: 'image/png,image/gif,image/jpeg'
					when :video
						file_field_tag "properties[#{property.name}]", id: property._id, accept: 'video/mpeg,video/x-flv,video/mp4,application/x-mpegURL,video/MP2T,video/3gpp,video/quicktime,video/x-msvideo,video/x-ms-wmv'
					when :music
						file_field_tag "properties[#{property.name}]", id: property._id, accept: 'audio/basic,auido/L24,audio/mpeg,audio/mid,audio/mp4,audio/x-aiff,audio/x-mpegurl,audio/vnd.rn-realaudio,audio/ogg,audio/vorbis,audio/vnd.wav'
					when :date
						"<input type='text' #{req} name='properties[#{property.name}]' class='form-control sel_date' id='#{property._id}'/>"
					when :time
						"<input type='text' #{req} name='properties[#{property.name}]' class='form-control sel_time' id='#{property._id}' data-format='hh:mm A'/>"
					when :link #暂时没有做格式过滤，和普通字符串没有区别
						"<input type='text' #{req} name='properties[#{property.name}]' class='form-control' id='#{property._id}' placeholder='#{property.description}...'/>"
					when :data_sheet #值还没有传回
						"<input type='hidden' name='properties[#{property.name}]' class='form-control'/><div class='handsontable-input'></div><input type='hidden' value='#{property.data_y || 10}'/><input type='hidden' value='#{property.data_x || 10}'/>"
					else
						"不支持的字段类型"
				 end

		input = "<div class='input-group'>#{input}</div>" if !front.nil? || !back.nil?
		label + input
	end
end
