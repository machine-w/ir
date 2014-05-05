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
		@group.group_members.build(user:@user,type: :master)
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
	def destroy
		error_msg=''
		status=true
    	group=@user.groups.find(params[:id])
    	if group.destroy
    		#del_contact_notification(@user,contact.firend)
    		error_msg='成功删除群组'
			status=true
    	else
    		error_msg='无法删除该群组'
			status=false
    	end
    	respond_to do |format|
            msg = { status: status.to_s, message: error_msg,group_id: params[:id] }
            format.json  { render :json => msg }
        end
	end
	def edit
		@group=@user.groups.find(params[:id])
		render :layout => 'blank'
	end
	def update
		group=@user.groups.find(params[:id])
		error_msg='错误：'

		if group.update_attributes(groups_params)
			flash[:success] = "修改目录成功"
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
