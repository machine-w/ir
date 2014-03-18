class Admin::DocumentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:index,:create]
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }
	layout "admin_layout"
	def create
		@doc = @folder.documents.new(document_params)
		if @doc.save
			redirect_to admin_folder_path(@folder), notice: '成功新建文档。'
		else
			redirect_to admin_folder_path(@folder), alert: '新建文档失败。'
		end
	end
	private 
	def set_folder
		@folder = @user.folders.find(params[:folder_id])
	end
	def document_params
		params.require(:document).permit(:title,:content_have_attr)
	end
end
