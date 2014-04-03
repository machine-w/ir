class Admin::DocumentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:index,:create]
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def create
		error_msg= ''
		@doc = @folder.documents.new document_params 
		@properties.each do |property| 
			if property_params.has_key? property.name
			 	attritube=@doc.attritubes.build(property_id: property._id,property_name: property.name,type: property.type)
			 	error_msg += attritube.save_value(property,property_params[property.name])
			else
				@doc.attritubes.build(property_id: property._id,property_name: property.name,type: property.type,bool_value: false) if property.bool? #如果类型类bool特殊对待，设定属性为否
				error_msg += "#{property.show_name}为必填字段;" if property.req?
			end 
		end
		if  error_msg == '' && @doc.save
			redirect_to admin_folder_path(@folder), notice: '成功新建文档。'
		else
			redirect_to admin_folder_path(@folder), alert: error_msg
		end
	end
	private 
	def set_folder
		@folder = @user.folders.find(params[:folder_id])
		@properties =@folder.all_properties
	end
	def document_params
		params.require(:document).permit(:title,:content_have_attr)
	end
	def property_params
		all_array=@folder.all_properties.map { |i| i.muli_enum? ? {i.name => [] } : i.name }
		result_hash=if params.has_key?(:properties)
					 	params.require(:properties).permit(all_array) 
					else 
						{}
					end
		hidden_array=@folder.all_properties.map { |i| i.name if i.array? }
		#logger.info hidden_array.to_s
		hidden_hash=if params.has_key?('hidden-properties')
						params.require('hidden-properties').permit(hidden_array.compact)
					else
						{}
					end
		#logger.info hidden_hash.to_s
		hidden_hash.each { |k,v| result_hash[k] = v unless v.blank? }
		result_hash
	end
end
