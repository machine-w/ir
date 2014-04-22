class SocketController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper
  before_filter :fix_logged_in

  def initialize_session
    #p "Session Initialized\n"
    controller_store[:online_user_count] = 0
  end
  def client_connected
    #p "a user connected\n"
    controller_store[:online_user_count] += 1
    connection_store[:channel] = WebsocketRails[@username]
    send_message :channel_info, {:channel => @username}
  end
  def client_disconnected
    #p "a user disconnected\n"
    controller_store[:online_user_count] -= 1
  end
  def firend_message
    p "#{message[:firendid]}333333333333\n"
  	WebsocketRails[message[:firendid]].trigger(:user_message, {:source_loginname => @username, :message => message[:text],small_message: message[:text],avatar: @avatar,showname: @showname,time: Time.now.strftime("%I:%M")})
  end

  private
  def fix_logged_in
    if user_signed_in?
      	@username = current_user.loginname
      	@avatar = current_user.avatar_url('normal')
      	@showname = current_user.username
    else
    	@username = 'websocket' #如果没有登录，则用一个永远不会有人用的id
    	@avatar = ' '
    	@showname = 'guest'
    end
  end
  
end