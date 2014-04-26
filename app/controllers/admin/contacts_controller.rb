class Admin::ContactsController < ApplicationController
	include ConversationsHelper
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def index
		@contacts=@user.contacts.all
		@have_firend = false
		@is_firend =  false
		firend_login=params.permit(:firend)[:firend]
		if User.where(loginname:firend_login).exists?
			@have_firend= true
			@source=User.where(loginname:firend_login).first
			@conversation=get_conversation(@user,@source)
			@conversation.set_readed(@source)
			if @user.contacts.where(firend:@source).exists?
				@is_firend = true
				@firend = @user.contacts.where(firend:@source).first
			end
		end
		drop_breadcrumb('我的好友', user_admin_contacts_path(@user.loginname))
	end
	def users_not_firend
		query=Regexp.new(params[:q])
		@all_users = User.or({username: query},{email: query}).nin(_id: @user.contacts.all.map { |e| e.firend_id }.push(@user._id))
		respond_to do |format|
			format.html
			format.json  { render :file => "admin/contacts/users_not_firend.json.erb", :content_type => 'application/json' }
		end
	end
	# 发现本单位的用户
	def department_not_firend
		@all_users = User.where(department: @user.department).nin(_id: @user.contacts.all.map { |e| e.firend_id }.push(@user._id))
		respond_to do |format|
			format.html
			format.json  { render :file => "admin/contacts/users_not_firend.json.erb", :content_type => 'application/json' }
		end
	end
	#发现本学科的用户
	def discipline_not_firend
		@all_users = []
		@user.third_disciplines.each do |d| 
			 @all_users |= d.users.nin(_id: @user.contacts.all.map { |e| e.firend_id }.push(@user._id)).entries #if d.users.nin(_id: @user.contacts.all.map { |e| e.firend_id }.push(@user._id)).entries
		end
		# @all_users = User.nin(_id: @user.contacts.all.map { |e| e.firend_id }).all(third_discipline_ids: @user.third_discipline_ids)
		respond_to do |format|
			format.html
			format.json  { render :file => "admin/contacts/users_not_firend.json.erb", :content_type => 'application/json' }
		end
	end
	def users_in_firend
		@all_users = @user.contacts.all.map { |e| [e.firend,e._id] }
		respond_to do |format|
			format.html
			format.json  { render :file => "admin/contacts/users_in_firend.json.erb", :content_type => 'application/json' }
		end
	end
	def create
		error_msg=''
		status=true
		user = User.find(params['add_id'])
		if @user.contacts.where(firend:user).exists? || @user._id == user._id
			status = false
			error_msg="已经添加过此好友"
		else
			@contact = @user.contacts.build({name: user.username,firend: user})
			if Conversation.all(user_ids: [@user._id,user._id]).exists?
				@conversation = Conversation.all(user_ids: [@user._id,user._id]).first
			else
				@conversation = Conversation.all.build(users: [@user,user])
				#@conversation.users.push user
			end
			if @contact.save && @conversation.save
				error_msg="新建好友成功"
				status = true
			else
				@contact.errors.full_messages.each do |msg|
					error_msg += msg + ','
				end
				@conversation.errors.full_messages.each do |msg|
					error_msg += msg + ','
				end
				status = false
			end
		end
		
		respond_to do |format|
			format.html
		    #format.xml  { render :xml => @users }
		    #format.json  { render :json => @users.to_json }
            msg = { status: status.to_s, message: error_msg,conversation_id: @conversation._id.to_s, contact_id: @contact._id.to_s, add_user: user,contact_home: user_path(user.loginname),contact_del:admin_contact_path(@contact) ,department: (user.department.name if user.department),type: (user.user_type.name if user.user_type),view_conversation_url: get_conversation_path(@user,user) }
            format.json  { render :json => msg }
        end
    end
    def destroy
    	error_msg=''
		status=true
    	contact=@user.contacts.find(params[:id])
    	if contact.destroy
    		error_msg='成功删除好友'
			status=true
    	else
    		error_msg='无法删除该好友'
			status=false
    	end
    	respond_to do |format|
            msg = { status: status.to_s, message: error_msg,contact_id: params[:id] }
            format.json  { render :json => msg }
        end
    end
    private

end
