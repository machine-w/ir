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
  protected
          def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:loginname,:username, :email, :password,) }
            devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
          end
end
