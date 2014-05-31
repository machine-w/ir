class HomeController < ApplicationController
  def index
  	documents =[]
  	@query_key=params[:q]
  	if @query_key.blank?
  		@all_docs=Document.all
  	else
  		@all_docs=Document.where(title: /.*#{@query_key}.*/)
  	end

  	@all_docs.each do |doc| 
  		documents.push doc if doc.visiable?(current_user)
  	end
  	@docs = Kaminari.paginate_array(documents).page(params[:page]).per(12)
  	#@docs = Document.all.page(params[:page]).per(24)
  end
end
