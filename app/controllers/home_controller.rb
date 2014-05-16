class HomeController < ApplicationController
  def index
  	@docs = Document.all.page(params[:page]).per(24)
  end
end
