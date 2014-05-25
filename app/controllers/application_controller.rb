class ApplicationController < ActionController::Base
  include Admin::GroupsHelper
  include ConversationsHelper
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
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:loginname,:username, :email, :password,:password_confirmation,:department,:user_type,:gender) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login,:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      results = u.permit(:username,:email, :password,:password_confirmation,:current_password,:department,{:third_disciplines => []},:user_type, :avatar, :avatar_cache,:gender)
      results[:department] = Department.find(results[:department])
      results[:user_type] = UserType.find(results[:user_type])
      results[:third_disciplines].map! { |e| ThirdDiscipline.find(e) unless e.blank? }
      results
    end
  end
  private
  #设置每页中的用户对象
  def set_user
    @user=current_user
  end

  def set_permission(param,host)
    error_msg = ""
    result=param.require(:permission).permit(:inherit,:private,:public_type,{:public_scope => []},{:sel_department => []},{:sel_discipline => []},{:sel_mygroup => []},{:sel_joingroup => []},{:sel_contact => []},:member_list,:end_date,:list_search_visiable,:send_message,:send_group_message)
    unless result[:public_scope].blank?
      result[:public_scope].map! do |e|
        scope = PermissionScope.find_or_initialize_by(type: e) unless e.blank?
        #logger.debug "111111#{e}222222"
        case e
        when 'sel_department'
          scope.array_value = result[:sel_department] || []
        when 'sel_discipline'
          scope.array_value = result[:sel_discipline] || []
        when 'my_group'
          scope.array_value = result[:sel_mygroup] || []
          auto_send_group_message(host,scope.array_value) if result.has_key?(:send_group_message) && host.class == Document
        when 'join_group'
          scope.array_value = result[:sel_joingroup] || []
          auto_send_group_message(host,scope.array_value) if result.has_key?(:send_group_message) && host.class == Document
        when 'sel_contact'
          scope.array_value = result[:sel_contact] || []
          auto_send_message(host,scope.array_value) if result.has_key?(:send_message) && host.class == Document
        when 'user_list'
          logger.debug result[:member_list]
          scope.array_value = JSON.parse(result[:member_list])
          auto_send_message(host,scope.array_value) if result.has_key?(:send_message) && host.class == Document
        end
        scope
      end
    end
    if result.has_key? :inherit
      host.permission.inherit = false
      if result.has_key? :private
        host.permission.privated = false
        host.permission.public_type = result['public_type']
        host.permission.list_search_visiable = result.has_key?(:list_search_visiable) ? true : false
        begin
          unless result['end_date'].blank?
            host.permission.end_date = Date.strptime(result['end_date'], "%Y年%m月%d日")
          else
            host.permission.end_date = nil
          end
        rescue
          error_msg ="日期格式错误;"
        end
        host.permission.permission_scopes = result['public_scope']
      else
        host.permission.privated = true
      end   
    else
      host.permission.inherit = true
    end
    error_msg
  end
  
end
