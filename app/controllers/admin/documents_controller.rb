class Admin::DocumentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:index,:create,:new]
	before_filter :set_document, only: [:edit,:update,:show,:destroy]
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
			#@folder.update_attribute(:doc_count, @folder.doc_count + 1 )
			redirect_to admin_folder_path(@folder), notice: '成功新建文档。'
		else
			#redirect_to new_admin_folder_document_path(@folder), alert: error_msg
			redirect_to :back, alert: error_msg
		end
	end
	def index
		@documents=@folder.documents.all.page(params[:page]).per(10)
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
	end
	def new
		@document=@folder.documents.new
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("新建文档", new_admin_folder_document_path(@folder))
	end
	def edit
		drop_breadcrumb(@document.folder.name, admin_folder_path(@document.folder))
		drop_breadcrumb(@document.title, admin_document_path(@document))
		drop_breadcrumb("修改文档", edit_admin_document_path(@document))
	end
	def update
		error_msg= ''
		@document.title = document_params[:title] if document_params.has_key? :title
        @document.content_have_attr = document_params[:content_have_attr] if document_params.has_key? :content_have_attr
		@properties.each do |property|
			if @document.attritubes.where(property_name: property.name).exists?
				attritube=@document.attritubes.where(property_name: property.name).first
			else
				attritube=@document.attritubes.build(property_id: property._id,property_name: property.name,type: property.type)
			end
			if property_params.has_key? property.name
			 	error_msg += attritube.save_value(property,property_params[property.name])
			else
				attritube.bool_value = false if property.bool? #如果类型类bool特殊对待，设定属性为否
				#@document.attritubes.build(property_id: property._id,property_name: property.name,type: property.type,bool_value: false) if property.bool? && !@document.attritubes.where(property_name: property.name).exists? #如果类型类bool特殊对待，设定属性为否
				error_msg += "#{property.show_name}为必填字段;" if property.req?
			end 
		end
		if  error_msg == '' && @document.save
			#redirect_to edit_admin_document_path(@document), notice: '成功修改文档。'
			redirect_to :back, notice: '成功修改文档。'
		else
			#redirect_to edit_admin_document_path(@document), alert: error_msg
			redirect_to :back, alert: error_msg
		end
		
	end
	def show
		drop_breadcrumb(@document.folder.name, admin_folder_path(@document.folder))
		drop_breadcrumb(@document.title, admin_document_path(@document))
	end
	def destroy
		@document.destroy
		redirect_to :back, notice: '成功删除文档。'
	end
	
	private 
	def set_folder
		@folder = @user.folders.find(params[:folder_id])
		@properties =@folder.all_properties
	end
	def set_document
		@document = Document.find(params[:id])
		@properties =@document.all_properties
		@folder = @document.folder
	end
	def document_params
		params.has_key?(:document) ? params.require(:document).permit(:title,:content_have_attr) : {}
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
