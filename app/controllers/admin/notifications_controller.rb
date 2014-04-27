class Admin::NotificationsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def index
		@notifications = @user.notifications.where(:created_at.gte => (Date.today - 7)).desc(:created_at)
		drop_breadcrumb('我的事件', user_admin_notifications_path(@user.loginname))
	end
end
