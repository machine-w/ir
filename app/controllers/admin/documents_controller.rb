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
				error_msg += "#{property.show_name}为必填字段\n" if property.req?
			end 
		end
		if @doc.save && error_msg == ''
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
		params.require(:properties).permit(@folder.all_properties.map { |i| i.name })
	end
end
