class Admin::GroupsController < ApplicationController
	include NotificationsHelper
	include Admin::GroupsHelper
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"

	def index
		@my_groups = @user.groups.all
		#@join_groups = Group.elem_match(group_members: { user_id: @user._id })
		@join_groups = @user.my_join_groups
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
	def show
		@group=Group.find(params[:id])
		if @group.group_members.where(user: @user).exists?
			@messages=@group.group_messages.limit(100).asc(:created_at)
			@members=@group.group_members.all.desc(:created_at)
		else
			@messages = []
			@members = []
		end
		respond_to do |format|
			format.html { redirect_to user_admin_groups_path(@user.loginname) }
			format.json  { render :file => "/admin/groups/show.json.erb", :content_type => 'application/json' }
		end
	end
	def add_member
		error_msg=''
		status=true
		@group=Group.find(params[:id])
		user = User.find(params['add_id'])
		if @group.enable_edit_member?(@user)
			if @group.group_members.where(user: user).exists?
				status = false
				error_msg="已经添加过此用户"
			else
				member = @group.group_members.build({user: user,type: :normal})
				if @group.save
					error_msg="新建组成员成功"
					status = true
				else
					@group.errors.full_messages.each do |msg|
						error_msg += msg + ','
					end
					status = false
				end
			end
		else
			status = false
			error_msg="无权修改组成员"
			member = @group.group_members.build({user: user,type: :normal})
		end

		respond_to do |format|
			format.html
		    #format.xml  { render :xml => @users }
		    #format.json  { render :json => @users.to_json }
            msg = { status: status.to_s, message: error_msg,name: user.username,
      				loginname: user.loginname,
      				type: member.type_name,
      				memberid: member._id.to_s,
      				avatar: user.avatar_url('normal'),
      				department: user.department.name }
            format.json  { render :json => msg }
        end
	end
	def del_member
		error_msg=''
		status=true
		@group=Group.find(params[:id])
		member = @group.group_members.find(params['memberid'])
		if @group.enable_edit_member?(@user)
			if member.destroy && @group.save
				error_msg="删除组成员成功"
				status = true
			else
				@group.errors.full_messages.each do |msg|
					error_msg += msg + ','
				end
				status = false
			end
		else
			status = false
			error_msg="无权修改组成员"	
		end	
		
		respond_to do |format|
			format.html
            msg = { status: status.to_s, message: error_msg}
            format.json  { render :json => msg }
        end
	end
	def modify_member
		error_msg=''
		status=true
		@group=Group.find(params[:id])
		member = @group.group_members.find(params['memberid'])
		if @group.enable_edit_member?(@user)
			member.type = params['type'].to_sym
			if  @group.save
				error_msg="修改组成员权限成功"
				status = true
			else
				@group.errors.full_messages.each do |msg|
					error_msg += msg + ','
				end
				status = false
			end
		else
			status = false
			error_msg="无权修改组成员"
		end
		
		respond_to do |format|
			format.html
            msg = { status: status.to_s, message: error_msg,type_name: member.type_name}
            format.json  { render :json => msg }
        end
	end
	def sign_out
		error_msg=''
		status=true
		@group=Group.find(params[:id])
		if @group.group_members.where(user: @user).exists?
			member=@group.group_members.where(user: @user).first
			unless member.master?
				if member.destroy && @group.save
					error_msg="退出群组成功"
					status = true
				else
					@group.errors.full_messages.each do |msg|
						error_msg += msg + ','
					end
					status = false
				end
			else
				status = false
				error_msg="群建立者无法退出群"	
			end
		else
			status = false
			error_msg="无法找到该成员"	
		end	
		
		respond_to do |format|
			format.html
			msg = { status: status.to_s, message: error_msg,group_id: @group._id.to_s }
			format.json  { render :json => msg }
		end
	end
	def add_message
		error_msg=''
		status=true
		@group=Group.find(params[:id])
		if @group.group_members.where(user: @user).exists?
			content=params.permit(:content)[:content]
			if @group.group_messages.create(from: @user,content: content)
				send_realtime_group_message(@group,@user,content)
	    		error_msg='成功发送群消息'
				status=true
	    	else
	    		error_msg='发送群消息失败'
				status=false
	    	end
		else
			status = false
			error_msg="非群组成员无法发送消息"
		end

		respond_to do |format|
			format.html
            msg = { status: status.to_s, message: error_msg}
            format.json  { render :json => msg }
        end
	end
	private
	def groups_params
		params.require(:group).permit(:name,:avatar,:has_home,:description)
	end
end
