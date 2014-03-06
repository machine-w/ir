class Admin::FoldersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
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
		
	end

	private 

	def folders_params
		params.require(:folder).permit(:name,:folder_type,:folder_group,:description)
	end
end
