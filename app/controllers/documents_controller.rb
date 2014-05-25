class DocumentsController < ApplicationController
	before_filter :set_user
	def show
		begin
			@document = Document.find(params[:id])
			@home_user = @document.folder.user
			render_404 unless @document.visiable?(current_user,false)
		rescue
			render_404
		end
	end
end
