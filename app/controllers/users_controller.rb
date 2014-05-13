class UsersController < ApplicationController
  helper :users
  before_filter :find_user, :only => [:show, :admin]
  before_filter :correct_user, :only => [:admin]
  layout "admin_layout", :only => :admin
  #add_breadcrumb "主页", :root_path
  def show
    @docs =[]
    @user.folders.each { |e| @docs+= e.documents.all.entries }
  end
  def admin
     drop_breadcrumb("后台", admin_user_path(@user.loginname))
     @tile_folders=@user.folders.has_tile
  end
  def index
    @total_user_count = User.count
    @all_users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      #format.json  { render :json => @users.to_json }
      format.json  { render :file => "users/index.json.erb", :content_type => 'application/json' }
    end
  end
  protected
  def find_user
    # 处理 login 有大写字母的情况
    if params[:id] != params[:id].downcase
      redirect_to request.path.downcase, :status => 301
      return
    end
    @user = User.where(:loginname => /^#{params[:id]}$/i).first
    render_404 if @user.nil?
  end
  def correct_user
    unless !current_user.nil? && @user == current_user
      flash[:notice]="请登录后再访问"
      redirect_to root_path
    end
  end
end
