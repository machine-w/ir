class ConversationsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def show
		@conversation=Conversation.find(params[:id])
		@messages=@conversation.messages.limit(100).asc(:created_at)
		@user_in_conversation=@conversation.users.entries
		respond_to do |format|
			format.html
			format.json  { render :file => "/conversations/show.json.erb", :content_type => 'application/json' }
		end
	end
	def update
		error_msg=''
		status=true
		@conversation=Conversation.find(params[:id]);
		@conversation.messages.build(from: @user,content:params.permit(:content)[:content])
		
		if @conversation.save
    		error_msg='成功发送消息'
			status=true
    	else
    		error_msg='发送消息失败'
			status=false
    	end
		respond_to do |format|
			format.html
            msg = { status: status.to_s, message: error_msg,name: @user.username,avatar: @user.avatar_url('normal') }
            format.json  { render :json => msg }
        end
	end
end
