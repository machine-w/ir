class Admin::TodolistsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def create
		get_data = todolists_params
		@todolist = @user.todolists.build(get_data)
		error_msg='错误：'
		if @todolist.save
			flash[:success] = "新建待办事宜成功"
		else
			@todolist.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to admin_user_path(@user.loginname)
	end
	private
	def todolists_params
		results = params.require(:todolist).permit(:content,:startend)
		results
	end
end
