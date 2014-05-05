class Admin::GroupsController < ApplicationController
	include ConversationsHelper
	include NotificationsHelper
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"

	def index
		@my_groups = @user.groups.all
		@new_group = @user.groups.build
	end
	def create
		@group = @user.groups.build(groups_params)
		error_msg='错误：'
		if @group.save
			flash[:success] = "新建目录成功"
		else
			@group.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to :back
	end
	private
	def groups_params
		params.require(:group).permit(:name,:avatar,:has_home,:description)
	end
end
