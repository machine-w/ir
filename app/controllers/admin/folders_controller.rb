class Admin::FoldersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def create
		@folder = @user.folders.build(folders_params)
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

	private 

	def folders_params
		params.require(:folder).permit(:name,:folder_type,:description)
	end
end
