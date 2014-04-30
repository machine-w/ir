class Admin::NotificationsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def index
		start_str=params.permit(:start)[:start]
		end_str=params.permit(:end)[:end]
		if start_str.blank?
			@notifications = @user.notifications.where(:created_at.gte => (Date.today - 7)).desc(:created_at)
		else
			start_time=Date.strptime(start_str, "%Y年%m月%d日")
			logger.debug start_time
			end_time = end_str.blank? ? (start_time + 1) : Date.strptime(end_str, "%Y年%m月%d日")
			logger.debug end_time
			@notifications = @user.notifications.and({:created_at.gte => start_time},{:created_at.lte => end_time}).desc(:created_at)
		end
		
		drop_breadcrumb('我的事件', user_admin_notifications_path(@user.loginname))
	end
	def read_all
		@user.notifications.un_read.each { |e| e.update_attribute(:unread,false) }
		redirect_to :back, notice: '全部用户事件已设为已读'
	end
end
