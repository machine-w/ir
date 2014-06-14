class FixviewController < ApplicationController
  def pubu
  	msg="{}"
  	if(params['pubu'] == 'true')
  		current_user.update_attribute(:view_pubu, 'pubu') if current_user
  		session[:view_pubu] = 'pubu'
  	else
  		current_user.update_attribute(:view_pubu,'list') if current_user
  		session[:view_pubu] = 'list'
  	end
  	respond_to do |format|
			format.html
			format.json  { render :json => msg }
	  end
  end
  def fixheader
  	msg="{}"
  	if(params['fixheader'] == 'true')
  		current_user.update_attribute(:view_fixheader, true) if current_user
  		session[:view_fixheader] = 'true'
  	else
  		current_user.update_attribute(:view_fixheader,false) if current_user
  		session[:view_fixheader] = 'false'
  	end
  	respond_to do |format|
			format.html
			format.json  { render :json => msg }
	end
  end
end
