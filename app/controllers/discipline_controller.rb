class DisciplineController < ApplicationController
  before_filter :set_discipline, only: [:show]
  def index
  end
  def show
  	documents =[]
  	@query_key=params[:q]
  	@ddg_name = @discipline.name
  	if @query_key.blank?
  		@all_docs=@discipline.users.all.inject([]) { |sum,u| sum + Document.or(u.folders.map { |f| {folder: f} }).entries }
  	else
  		@all_docs=@discipline.users.all.inject([]) { |sum,u| sum + Document.or(u.folders.map { |f| {folder: f} }).where(title: /.*#{@query_key}.*/).entries }
  	end

  	@all_docs.each do |doc| 
  		documents.push doc if doc.visiable?(current_user)
  	end
  	@docs = Kaminari.paginate_array(documents).page(params[:page]).per(12)
  	render 'home/index'
  end
  private

  def set_discipline
  	@discipline = ThirdDiscipline.find(params[:id])
  end
end
