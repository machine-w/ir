class HomeController < ApplicationController
  def index
  	documents =[]
  	Document.all.each do |doc| 
  		documents.push doc if doc.visiable?(current_user)
  	end
  	@docs = Kaminari.paginate_array(documents).page(params[:page]).per(10)
  	#@docs = Document.all.page(params[:page]).per(24)
  end
end
