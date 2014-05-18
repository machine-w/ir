class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      BackgroundWorker.trigger(resource)
    end
    session[:view_pubu] = resource.view_pubu
    session[:view_fixheader] = resource.view_fixheader.to_s
  end
  def destroy
  	super do |resource|
      BackgroundWorker.trigger(resource)
    end
    session[:view_pubu] = nil
    session[:view_fixheader] = nil
  end
end