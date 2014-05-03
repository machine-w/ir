class RegistrationsController < Devise::RegistrationsController
  include NotificationsHelper
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }, only: [:edit,:update]
  def update
    super do |resource|
      #BackgroundWorker.trigger(resource)
    end
    modify_user_notification(resource)
  end
  protected
  def after_update_path_for(resource)
  	edit_user_registration_path
  end
end