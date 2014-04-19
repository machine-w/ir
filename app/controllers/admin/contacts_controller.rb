class Admin::ContactsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def index
		@contacts=@user.contacts.all
		drop_breadcrumb('我的好友', user_admin_contacts_path(@user.loginname))
	end
	def users_not_firend
		@all_users = User.nin(_id: @user.contacts.all.map { |e| e.firend_id })
		respond_to do |format|
			format.html
			format.json  { render :file => "admin/contacts/users_not_firend.json.erb", :content_type => 'application/json' }
		end
	end
	def users_in_firend
		@all_users = @user.contacts.all.map { |e| e.firend }
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
			if @contact.save
				error_msg="新建好友成功"
				status = true
			else
				@folder.errors.full_messages.each do |msg|
					error_msg += msg + ','
				end
				status = false
			end
		end
		
		respond_to do |format|
			format.html
		    #format.xml  { render :xml => @users }
		    #format.json  { render :json => @users.to_json }
            msg = { status: status.to_s, message: error_msg, add_user: user,department: (user.department.name if user.department),type: (user.user_type.name if user.user_type) }
            format.json  { render :json => msg }
        end
    end
    private

end
