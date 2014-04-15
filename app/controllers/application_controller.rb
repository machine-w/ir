class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def render_404
    render_optional_error_file(404)
  end

  def render_403
    render_optional_error_file(403)
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    if ["404","403", "422", "500"].include?(status)
      render :template => "/errors/#{status}", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    else
      render :template => "/errors/unknown", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    end
  end
  def after_sign_in_path_for(resource)
    admin_user_url(resource.loginname)
  end
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
  def after_update_path_for(resource)
    admin_user_url(resource.loginname)
  end
  def drop_breadcrumb(title=nil, url=nil)
    #title ||= @page_title
    url ||= url_for
    if title
      @breadcrumbs.push(%(<a href="#{url}" itemprop="url"><span itemprop="title">#{title}</span></a>).html_safe)
    end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:loginname,:username, :email, :password,:user_type,:gender) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login,:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      results = u.permit(:username,:email, :password,:password_confirmation,:current_password,:department,:third_disciplines,:user_type, :avatar, :avatar_cache,:gender)
      results[:department] = Department.find(results[:department])
      results[:user_type] = UserType.find(results[:user_type])
      results
    end
  end
  private
  #设置每页中的用户对象
  def set_user
    @user=current_user
  end

end
