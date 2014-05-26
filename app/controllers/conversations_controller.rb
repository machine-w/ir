class ConversationsController < ApplicationController
	include ConversationsHelper
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def show
		@conversation=Conversation.find(params[:id])
		@user_in_conversation=@conversation.users.entries
	    @user_in_conversation.each{ |x| @firend = x if x != @user }
	    if @user.contacts.where(firend: @firend).exists?
	    	@messages=@conversation.messages.limit(100).asc(:created_at)
	    else
	    	@messages=[]
	    end
	    @conversation.set_readed(@conversation.get_other_user(@user))
		respond_to do |format|
			format.html
			format.json  { render :file => "/conversations/show.json.erb", :content_type => 'application/json' }
		end
	end
	def update
		error_msg=''
		status=true
		@conversation=Conversation.find(params[:id]);
		content=params.permit(:content)[:content]
		
		if message=@conversation.messages.create(from: @user,content: content)
			send_realtime_message(@conversation,@user,message)
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
	def read_all
		set_unread_messages(@user)
		redirect_to :back, notice: '全部用户信息已设为已读'
	end
end
