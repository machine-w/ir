class Admin::SearchController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"

	def index
		@documents=Document.or(@user.folders.map { |f| {folder: f} }).where(title: /.*#{params[:q]}.*/).page(params[:page]).per(15)
		drop_breadcrumb("检索文档", "#")
	end
end
