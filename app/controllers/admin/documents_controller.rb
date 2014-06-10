class Admin::DocumentsController < ApplicationController
	include NotificationsHelper
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:index,:create,:new,:children_folder,:copy_document]
	before_filter :set_document, only: [:edit,:update,:show,:destroy,:config_permission,:permission_model,:config_parent_visiable]
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
				#@doc.attritubes.build(property_id: property._id,property_name: property.name,type: property.type,bool_value: false) if property.bool? #如果类型类bool特殊对待，设定属性为否
				error_msg += "#{property.show_name}为必填字段;" if property.req?
			end 
		end
		#@doc.build_permission({inherit: true})
		if  error_msg == '' && @doc.save
			add_doc_notification(@user,@doc)
			redirect_to admin_folder_path(@folder), notice: '成功新建文档。'
		else
			#redirect_to new_admin_folder_document_path(@folder), alert: error_msg
			redirect_to :back, alert: error_msg
		end
	end
	def index
		@my_doc = true
		@query_key=params[:q]
		if @query_key.blank?
			@documents=@folder.documents.all.page(params[:page]).per(12)
		else
			@documents=@folder.documents.where(title: /.*#{@query_key}.*/).page(params[:page]).per(12)
		end
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
	end
	def children_folder
		@my_doc = false
		@query_key=params[:q]
		@query_child=params[:child]
		@documents=Kaminari.paginate_array(@folder.children_folder_documents(@query_key,@query_child)).page(params[:page]).per(12)
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
	end
	def copy_document
		error_msg=''
		status=true
		begin
			@org_doc=Document.find(params[:doc_id])
			#@folder.documents.push(@org_doc.dup)
			if doc=@folder.documents.create(title: @org_doc.title,
				summary: @org_doc.summary,
				content_have_attr: @org_doc.content_have_attr,
				content_html: @org_doc.content_html,
				content_html_summary: @org_doc.content_html_summary,
				attritubes: @org_doc.attritubes
				)
				copy_doc_notification(@user,doc,@folder)
				error_msg="成功复制#{truncate(@org_doc.title, :length => 10)}到'#{truncate(@folder.name, :length => 10)}'"
				status=true
			else
				@folder.errors.full_messages.each do |msg|
					error_msg += msg + '|'
				end
				status=false
			end
			
		rescue 
			status=false
			error_msg='无法找到源文档'
		end
		respond_to do |format|
			format.html
            msg = { status: status.to_s, message: error_msg }
            format.json  { render :json => msg }
        end	
	end
	def new
		@document=@folder.documents.new
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("新建文档", new_admin_folder_document_path(@folder))
	end
	def edit
		if @parent_folder.nil?
			drop_breadcrumb(@document.folder.name, admin_folder_path(@document.folder))
			drop_breadcrumb(@document.title, admin_document_path(@document))
			drop_breadcrumb("修改文档", edit_admin_document_path(@document))
		else
			drop_breadcrumb(@parent_folder.name, admin_folder_path(@parent_folder))
			drop_breadcrumb(@document.title, admin_document_path(@document,folder: @parent_folder))
			drop_breadcrumb("修改文档", edit_admin_document_path(@document,folder: @parent_folder))
		end
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
				#attritube.bool_value = false if property.bool? #如果类型类bool特殊对待，设定属性为否
				#@document.attritubes.build(property_id: property._id,property_name: property.name,type: property.type,bool_value: false) if property.bool? && !@document.attritubes.where(property_name: property.name).exists? #如果类型类bool特殊对待，设定属性为否
				error_msg += "#{property.show_name}为必填字段;" if property.req?
			end 
		end
		if  error_msg == '' && @document.save
			modify_doc_notification(@user,@document)
			if @document.folder.parent_folder && @document.view_in_parent
				child_modify_doc_notification(@user,@document.folder,@document,@document.folder.parent_folder,@document.folder.parent_folder.user)
			end
			redirect_to :back, notice: '成功修改文档。'
		else
			#redirect_to edit_admin_document_path(@document), alert: error_msg
			redirect_to :back, alert: error_msg
		end	
	end
	def show
		if @parent_folder.nil?
			drop_breadcrumb(@document.folder.name, admin_folder_path(@document.folder))
			drop_breadcrumb(@document.title, admin_document_path(@document))
		else #如果是从父目录编辑
			drop_breadcrumb(@parent_folder.name, admin_folder_path(@parent_folder))
			drop_breadcrumb(@document.title, admin_document_path(@document,folder: @parent_folder))
		end
		
	end
	def destroy
		@document.destroy
		del_doc_notification(@user,@document)
		redirect_to :back, notice: '成功删除文档。'
	end
	def config_permission
		error_msg= ''
		error_msg= set_permission(params,@document)
		if  error_msg == '' && @document.save
			redirect_to :back, notice: '成功修改权限。'
		else
			redirect_to :back, alert: error_msg
		end
	end
	def config_parent_visiable
		error_msg=''
		status=true
		if @document.update_attribute(:view_in_parent, params[:visiable] == 'true' ? true : false)
			if @document.view_in_parent
				child_share_doc_notification(@user,@document.folder,@document,@document.folder.parent_folder,@document.folder.parent_folder.user)
			else
				child_shield_doc_notification(@user,@document.folder,@document,@document.folder.parent_folder,@document.folder.parent_folder.user)
			end
			
			error_msg="成功配置#{truncate(@document.title, :length => 10)}"
			status=true
		else
			@document.errors.full_messages.each do |msg|
   				error_msg += msg + '|'
   			end
   			status=false
		end
		respond_to do |format|
			format.html
            msg = { status: status.to_s, message: error_msg }
            format.json  { render :json => msg }
        end	
	end
	def permission_model
		render :layout => 'blank'
	end
	private 
	def set_folder
		@folder = @user.folders.find(params[:folder_id])
		@properties =@folder.all_dynamic_properties
	end
	def set_document
		begin
			@document = Document.find(params[:id])
			@folder = @document.folder
			parent_folder_id=params[:folder]
			if parent_folder_id.blank?
				@identify_properties = @document.all_identify_properties
				@properties =@document.all_dynamic_properties
				render_404 if @folder.user != @user
			else
				@parent_folder = Folder.find(parent_folder_id)
				@properties =@parent_folder.all_dynamic_properties
				@identify_properties = @parent_folder.all_identify_properties
				render_404 unless @document.view_in_parent
				render_404 unless @document.folder.allow_parent_edit?(@parent_folder)
				render_404 unless @parent_folder.user == @user
			end
		rescue
			redirect_to admin_user_url(@user.loginname), notice: '成功删除文档。'
		end
	end
	def document_params
		params.has_key?(:document) ? params.require(:document).permit(:title,:content_have_attr) : {}
	end
	def property_params
		all_array=@properties.map { |i| i.muli_enum? ? {i.name => [] } : i.name }
		result_hash=if params.has_key?(:properties)
					 	params.require(:properties).permit(all_array) 
					else 
						{}
					end
		hidden_array=@properties.map { |i| i.name if i.array? }
		#logger.info hidden_array.to_s
		hidden_hash=if params.has_key?('hidden-properties')
						params.require('hidden-properties').permit(hidden_array.compact)
					else
						{}
					end
		#logger.info hidden_hash.to_s
		hidden_hash.each { |k,v| result_hash[k] = v unless v.blank? }
		@properties.each do |i| 
			if i.muli_enum?
				result_hash["#{i.name}"] = result_hash["#{i.name}"] || []
			elsif i.enum?
				result_hash["#{i.name}"] = result_hash["#{i.name}"] || ''
			elsif i.bool?
				result_hash["#{i.name}"] = result_hash["#{i.name}"] || false
			end
		end
		logger.debug { result_hash.to_s }
		result_hash
	end
end
