class RegistrationsController < Devise::RegistrationsController
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