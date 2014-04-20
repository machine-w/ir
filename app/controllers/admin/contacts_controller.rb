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
		#@all_users = User.elem_match(third_disciplines: { "$in" => @user.third_disciplines}).nin(_id: @user.contacts.all.map { |e| e.firend_id })
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
            msg = { status: status.to_s, message: error_msg, contact_id: @contact._id.to_s, add_user: user,contact_home: user_path(user.loginname),contact_del:admin_contact_path(@contact) ,department: (user.department.name if user.department),type: (user.user_type.name if user.user_type) }
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
