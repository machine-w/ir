class DocumentsController < ApplicationController
	before_filter :set_user
	def show
		begin
			@document = Document.find(params[:id])
			@home_user = @document.folder.user
		rescue
			render_404
		end
	end
end
