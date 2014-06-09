class Admin::FoldersController < ApplicationController
	include NotificationsHelper
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:show, :edit, :update, :destroy,:children_folder, :config_property,:config_doc_view,:update_doc_view,:config_static_properties,:config_permission,:update_permission,:update_static_properties,:config_share_permission,:update_share_permission,:config_share_property]
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def create
		get_data = folders_params
		#判断目录集名是否已存在
		if @user.folder_groups.where(:name => get_data[:folder_group]).exists?
			get_data[:folder_group] = @user.folder_groups.where(:name => get_data[:folder_group]).first._id
		end
		#判断目录集是否为新建
		unless @user.folder_groups.where(:id => get_data[:folder_group]).exists?
			new_folder_group = @user.folder_groups.create(name: get_data[:folder_group])
			get_data[:folder_group] = new_folder_group._id
		end
		# if folders_params['tile'] == '1'
		# 	get_data['tile'] = true
		# else
		# 	get_data['tile'] = false
		# end
		@folder = @user.folders.build(get_data)
		error_msg='错误：'
		if @folder.save
			add_folder_notification(@user,@folder)
			flash[:success] = "新建目录成功"
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to admin_user_path(@user.loginname)
	end
	def new
		drop_breadcrumb("新建目录", new_user_admin_folder_path(@user.loginname))
		@folder = @user.folders.build
		@folder_group_json=@user.folder_groups.all.to_json(:only => [ :_id, :name ])
	end
	def index
		@folders =@user.folders.all
		respond_to do |format|
			format.html
			format.json { render :json => @folders.to_json(include: {:folder_type => { only: [:image_path]}},only: [:_id,:name]) }  
		end
	end

	def show
		#@folder = Folder.find(params[:id])
		@my_doc = true
		@document=@folder.documents.new
		@query_key=params[:q]
		if @query_key.blank?
			@documents=@folder.documents.all.page(params[:page]).per(12)
		else
			@documents=@folder.documents.where(title: /.*#{@query_key}.*/).page(params[:page]).per(12)
		end
		
		@properties =@folder.all_dynamic_properties
		@identify_properties = @folder.all_identify_properties
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
	end
	def children_folder
		@document=@folder.documents.new
		@my_doc = false
		@query_key=params[:q]
		@query_child=params[:child]
		@documents=Kaminari.paginate_array(@folder.children_folder_documents(@query_key,@query_child)).page(params[:page]).per(12)
		@properties =@folder.all_dynamic_properties
		@identify_properties = @folder.all_identify_properties
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
	end
	def edit
		#@folder = Folder.find(params[:id])
		@folder_group_value = @folder.folder_group ? @folder.folder_group._id : ""
		@folder_group_json=@user.folder_groups.all.to_json(:only => [ :_id, :name ])
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("配置基本信息", edit_admin_folder_path(@folder))
	end
	def config_property
		@property=@folder.properties.build
		@query_key=params[:q]
		@properties = @folder.all_all_properties(@query_key)
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("配置文档属性", config_property_admin_folder_path(@folder))
	end
	def config_share_property
		@query_key=params[:q]
		if @query_key.blank?
			@properties=@folder.properties.all
		else
			@properties=@folder.properties.where(name: /.*#{@query_key}.*/)
		end
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("配置共享权限", config_property_admin_folder_path(@folder))
	end
	def config_doc_view
		@properties=@folder.properties.all
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("配置文档视图", config_doc_view_admin_folder_path(@folder))
	end
	def config_static_properties
		@static_properties=@folder.all_static_properties
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("配置静态属性", config_doc_view_admin_folder_path(@folder))
	end
	def config_permission
		drop_breadcrumb("配置共享范围", config_property_admin_folder_path(@folder))
	end
	def update_permission
		error_msg= ''
		error_msg= set_permission(params,@folder)
		if  error_msg == '' && @folder.save

			redirect_to :back, notice: '成功修改权限。'
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
			redirect_to :back, alert: error_msg
		end
	end
	def config_share_permission
		
	end
	def update_share_permission
		error_msg= ''
		error_msg= set_share_permission(params,@folder)
		if  error_msg == '' && @folder.save
			redirect_to :back, notice: '成功修改权限。'
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
			redirect_to :back, alert: error_msg
		end
	end
	def update
		get_data = folders_params
		#判断目录集名是否已存在
		# if @user.folder_groups.where(:name => get_data[:folder_group]).exists?
		# 	get_data[:folder_group] = @user.folder_groups.where(:name => get_data[:folder_group]).first
		# end
		#判断目录集是否为新建
		if get_data[:folder_group].blank?
			get_data[:folder_group] = nil
		else
			unless @user.folder_groups.where(:id => get_data[:folder_group]).exists?
				new_folder_group = @user.folder_groups.create(name: get_data[:folder_group])
				get_data[:folder_group] = new_folder_group
			else
				get_data[:folder_group] = @user.folder_groups.find(get_data[:folder_group])
			end
		end
		# if folders_params['tile'] == '1'
		# 	get_data['tile'] = true
		# else
		# 	get_data['tile'] = false
		# end
		#@folder = @user.folders.build(get_data)
		error_msg='错误：'
		@folder.name=get_data[:name]
		@folder.description=get_data[:description]
		@folder.folder_type=FolderType.find(get_data[:folder_type])
		@folder.folder_group=get_data[:folder_group]
		@folder.tile = get_data[:tile]
		@folder.tile_color = get_data[:tile_color]
		if @folder.save
			modify_folder_notification(@user,@folder)
			flash[:success] = "修改目录成功"
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to action: 'edit'
	end
	def update_doc_view
		error_msg='错误：'
		@folder.doc_default_content=folders_params[:doc_default_content]
		if @folder.save
			@folder.set_dirty_all_documents #目录中全部文档治脏。
			modify_view_folder_notification(@user,@folder)
			flash[:success] = "修改文档视图成功"
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to action: 'config_doc_view'
	end
	def update_static_properties
		error_msg=''
		@folder.all_static_properties.each do |property|
			if @folder.attritubes.where(property_name: property.name).exists?
				attritube=@folder.attritubes.where(property_name: property.name).first
			else
				attritube=@folder.attritubes.build(property_id: property._id,property_name: property.name,type: property.type)
			end
			if property_params.has_key? property.name
			 	error_msg += attritube.save_value(property,property_params[property.name])
			else
				attritube.bool_value = false if property.bool? #如果类型类bool特殊对待，设定属性为否
				error_msg += "#{property.show_name}为必填字段;" if property.req?
			end 
		end
		if  error_msg == '' && @folder.save
			@folder.set_dirty_all_documents #目录中全部文档治脏。
			modify_static_folder_notification(@user,@folder)
			redirect_to :back, notice: '成功修改静态属性。'
		else
			#redirect_to edit_admin_document_path(@document), alert: error_msg
			redirect_to :back, alert: error_msg
		end
	end
	def destroy
		error_msg='错误：'
		folder_group=@folder.folder_group
		properties=@folder.all_all_properties('')
		children = @folder.child_folders.all
		if @folder.destroy
			#如果目录集中没有别的目录了，就删除目录集合
			unless folder_group.nil?
				unless folder_group.folders.exists?
					folder_group.destroy
				end
			end
			#子目录添加父目录属性
			children.each do |f|  
				#properties.each { |e| f.properties.push(e) } 
				f.properties.concat(properties)
			end
			del_folder_notification(@user,@folder)
			flash[:success] = "删除目录成功"
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
   		end
		redirect_to admin_user_path(@user.loginname)
	end

	private 
	def set_folder
		@folder = @user.folders.find(params[:id])
	end
	def folders_params
		results = params.require(:folder).permit(:name,:folder_type,:parent_folder,:folder_group,:tile,:tile_color,:description,:doc_default_content)
		if results[:parent_folder].blank?
			results[:parent_folder] = nil
		else
			begin
				results[:parent_folder] = Folder.find(results[:parent_folder])
			rescue
				results[:parent_folder] = nil
			end
			
		end
		results
	end
	def property_params
		all_array=@folder.all_static_properties.map { |i| i.muli_enum? ? {i.name => [] } : i.name }
		result_hash=if params.has_key?(:properties)
					 	params.require(:properties).permit(all_array) 
					else 
						{}
					end
		hidden_array=@folder.all_static_properties.map { |i| i.name if i.array? }
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
