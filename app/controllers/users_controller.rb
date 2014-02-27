class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :index]
  def show
    
  end
  def admin
    @folders=["我的成果","我的笔记","我的相册","我的文件","我的参考文献"]
    @groups=["cc","dd"]
  end
  def index
    @total_user_count = User.count
    #@active_users = User.hot.limit(100)
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
end
