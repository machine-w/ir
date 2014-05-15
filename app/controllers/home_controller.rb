class HomeController < ApplicationController
  def index
  	@docs = Document.all.page(params[:page]).per(12)
  end
end
