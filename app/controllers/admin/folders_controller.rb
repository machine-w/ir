class Admin::FoldersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:show, :edit, :update, :destroy, :config_property]
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
		if folders_params['tile'] == '1'
			get_data['tile'] = true
		else
			get_data['tile'] = false
		end
		@folder = @user.folders.build(get_data)
		error_msg='错误：'
		if @folder.save
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

	end
	def show
		#@folder = Folder.find(params[:id])
		@document=@folder.documents.new
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
		@properties=@folder.properties.all
		drop_breadcrumb(@folder.name, admin_folder_path(@folder))
		drop_breadcrumb("配置文档属性", config_property_admin_folder_path(@folder))
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
		if folders_params['tile'] == '1'
			get_data['tile'] = true
		else
			get_data['tile'] = false
		end
		#@folder = @user.folders.build(get_data)
		error_msg='错误：'
		@folder.name=get_data[:name]
		@folder.description=get_data[:description]
		@folder.folder_type=FolderType.find(get_data[:folder_type])
		@folder.folder_group=get_data[:folder_group]
		@folder.tile = get_data[:tile]
		@folder.tile_color = get_data[:tile_color]
		if @folder.save
			flash[:success] = "修改目录成功"
		else
			@folder.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to action: 'edit'
	end
	def destroy
		error_msg='错误：'
		folder_group=@folder.folder_group
		if @folder.destroy
			#如果目录集中没有别的目录了，就删除目录集合
			unless folder_group.nil?
				unless folder_group.folders.exists?
					folder_group.destroy
				end
			end
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
		params.require(:folder).permit(:name,:folder_type,:folder_group,:tile,:tile_color,:description)
	end
end
