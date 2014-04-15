class RegistrationsController < Devise::RegistrationsController
	before_filter lambda  { drop_breadcrumb("后台", admin_user_path(@user.loginname)) }, only: [:edit]
  # def update
  #   super do |resource|
  #     #BackgroundWorker.trigger(resource)
  #   end
  # end
  protected
  def after_update_path_for(resource)
  	edit_user_registration_path
  end
end