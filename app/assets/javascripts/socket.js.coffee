jQuery ->
  window.chatController = new Chat.Controller($('#ir-body').data('uri'));

window.Chat = {}

class Chat.Controller
  headmessageTemplate: (small_message,avatar,showname,time) ->
    html =
      """
      <li>
          <a href="#">
              <div class="pull-left">
                  <img src="#{avatar}" alt="user image" class="img-circle"/>
              </div>
              <h4>
                  #{showname}
                  <small><i class="fa fa-clock-o"></i>#{time}</small>
              </h4>
              <p>#{small_message}</p>
          </a>
      </li>
      """
    $(html)

  boxmessageTemplate: (message,avatar,showname,time) ->
    html =
      """
      <div class="item">
        <img src="/images/avatar/female_normal.png" alt="user image" class="online"/>
        <p class="message">
          <a href="#" class="name">
            <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> 2:15</small>
            Mike Doe
          </a>
          I would like to meet you to discuss the latest news about
          the arrival of the new theme. They say it is going to be one the
          best themes on the market
        </p>
        <div class="attachment">
          <h4>Attachments:</h4>
          <p class="filename">
            Theme-thumbnail-image.jpg
          </p>
          <div class="pull-right">
            <button class="btn btn-primary btn-sm btn-flat">Open</button>
          </div>
        </div>
      </div>
      """
    $(html)

  # userListTemplate: (userList) ->
  #   userHtml = ""
  #   for user in userList
  #     userHtml = userHtml + "<li>#{user.user_name}</li>"
  #   $(userHtml)

  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url)
    #@dispatcher.on_open = @createChannel
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'channel_info', @setChannelInfo
    #@dispatcher.bind 'broadcast_info', @setBroadcastlInfo
    $('#add_message').click @sendMessage


  setChannelInfo: (channelInfo) =>
    @username = channelInfo.channel
    #alert @username
    @channel = @dispatcher.subscribe(@username)
    @channel.bind 'user_message', @receiveMessage

  receiveMessage: (message) =>
    #alert $('#head_message_num').text()
    #alert message.source_loginname
    if $('#add_message').length == 0 || $('#add_message').data('firendloginname') != message.source_loginname
      $('#ul_head_message').append @headmessageTemplate(message.small_message,message.avatar,message.showname,message.time)
      $('#head_message_num').animate({backgroundColor: '#f0ad4e'},500)
      $('#head_message_num').html((parseInt($('#head_message_num').text())+1)+'')
      $('#head_message_num').animate({backgroundColor: '#5cb85c'},500)
      $('#head_message_num2').html((parseInt($('#head_message_num2').text())+1)+'')
    
  sendMessage: (e) =>
    e.preventDefault()
    message = $('#message_content').val()
    firend_id = $('#add_message').data('firendloginname')
    @dispatcher.trigger 'firend_message', text: message, firendid: firend_id
    $('#message_content').val('')

  # newMessage: (message) =>
  #   @messageQueue.push message
  #   @shiftMessageQueue() if @messageQueue.length > 15
  #   @appendMessage message

  # sendMessage: (event) =>
  #   event.preventDefault()
  #   message = $('#message').val()
  #   @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}
  #   $('#message').val('')

  # updateUserList: (userList) =>
  #   $('#user-list').html @userListTemplate(userList)

  # updateUserInfo: (event) =>
  #   @user.user_name = $('input#user_name').val()
  #   $('#username').html @user.user_name
  #   @dispatcher.trigger 'change_username', @user.serialize()

  # appendMessage: (message) ->
  #   messageTemplate = @template(message)
  #   $('#chat').append messageTemplate
  #   messageTemplate.slideDown 140

  # shiftMessageQueue: =>
  #   @messageQueue.shift()
  #   $('#chat div.messages:first').slideDown 100, ->
  #     $(this).remove()

  # createGuestUser: =>
  #   @dispatcher.trigger 'new_channel', {}

  