class SocketController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def initialize_session
    p "Session Initialized\n###############################################"
  end
  def client_connected
    p "a user connected\n"
    #system_msg :new_message, "client #{client_id} connected"
  end
  
end