class Admin::FoldersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def create
	end
	def new
		
		drop_breadcrumb("新建目录", new_user_admin_folder_path(@user.loginname))
	end
	def index
	end
end
