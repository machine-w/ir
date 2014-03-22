module Admin::DocumentsHelper
	def get_property_form_view(property)
		label = "<label for='#{property._id}' class='control-label'>#{property.show_name}</label>"
		req = "check-type='required' required-message='#{property.show_name}为必填字段'" if property.req? || ((property.string? || property.text?) && property.have_min?)
		maxlength = "maxlength = '#{property.max_value}' " if property.have_max?
		minlength = "minlength = '#{property.min_value}' " if property.have_min?
		front = "<span class='input-group-addon'>#{property.front_ext}</span>" if property.have_front?
		back = "<span class='input-group-addon'>#{property.back_ext}</span>" if property.have_back?
		input = case property.type
					when :string
						"#{front}<input type='text' #{req} #{maxlength} #{minlength} name='properties[#{property.name}]' class='form-control' id='#{property._id}' placeholder='#{property.description}...'/> #{back}"
					when :integer #数字的最大最小值并没有在前端验证
						"#{front}<input type='text' #{req} name='properties[#{property.name}]' class='form-control inputnumber' id='#{property._id}' placeholder='#{property.description}...'/> #{back}"
					when :number #数字的最大最小值并没有在前端验证
						"#{front}<input type='text' #{req} name='properties[#{property.name}]' class='form-control inputdecimal' id='#{property._id}' placeholder='#{property.description}...'/> #{back}"
					when :text 
						"<textarea type='text' #{req} #{maxlength} #{minlength} class='form-control' placeholder='#{property.description}...'></textarea>"
				 end

		input = "<div class='input-group'>#{input}</div>" if !front.nil? || !back.nil?
		label + input
	end
end
