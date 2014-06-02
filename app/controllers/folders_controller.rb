class FoldersController < ApplicationController
  before_filter :set_user
  before_filter :find_user, :only => [:shared]
  def create
  end

  def index
  end
  def show
  	begin
  		@folder = Folder.find(params[:id])
  		documents =[]
      @query_key=params[:q]
      if @query_key.blank?
        @all_docs=@folder.documents.all
      else
        @all_docs=@folder.documents.all.where(title: /.*#{@query_key}.*/)
      end
  		@all_docs.each do |doc| 
        documents.push doc if doc.visiable?(current_user)
      end
  		@docs = Kaminari.paginate_array(documents).page(params[:page]).per(10)
      @home_user = @folder.user
  	rescue
  		render_404
  	end
  end
  def shared
    @all_shared_folders =@home_user.folders.all.entries.find_all{|n| n.share_visiable?(@user) }
    respond_to do |format|
      format.html
      format.json { render :json => @all_shared_folders.to_json(include: {:folder_type => { only: [:image_path]}},only: [:_id,:name]) }  
      # format.json { render :file => "folders/shared_folders.json.erb", :content_type => 'application/json' }
    end
  end
  protected
  def find_user
    # 处理 login 有大写字母的情况
    if params[:user_id] != params[:user_id].downcase
      redirect_to request.path.downcase, :status => 301
      return
    end
    @home_user = User.where(:loginname => /^#{params[:user_id]}$/i).first
    render_404 if @home_user.nil?
  end
end
