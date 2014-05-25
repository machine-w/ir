class FoldersController < ApplicationController
  before_filter :set_user
  def create
  end

  def index
  end
  def show
  	begin
  		folder = Folder.find(params[:id])
  		documents =[]
  		folder.documents.all.each do |doc| 
        documents.push doc if doc.visiable?(current_user)
      end
  		@docs = Kaminari.paginate_array(documents).page(params[:page]).per(10)
      @home_user = folder.user
  	rescue
  		render_404
  	end
  end
end
