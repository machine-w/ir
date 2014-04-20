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
end
