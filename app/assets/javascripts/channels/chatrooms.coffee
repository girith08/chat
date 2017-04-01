App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0
      console.log 'jest chatroom' #uzyj console.log do pomocy
      active_chatroom.append("<div class='message'>
      <a href='' class='message_profile-pic'></a>
      <a href='' class='message_username'><strong>#{data.email}</strong></a>
      <span class='message_star'></span>
      <span class='message_content'>
      #{data.body}
      </span>
      </div>")
    else
      console.log 'nie ma chatroom'
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")
      chatroom_id = data.chatroom_id
      $('tbody').append("<tr><td><a href='/chatrooms/#{chatroom_id}'>Nazwa</a></td></tr>")
    $messages = $('#messages')
    $messages.scrollTop $messages.prop('scrollHeight')

  speak: (chatroom_id, message) ->
    @perform 'speak', {chatroom_id: chatroom_id, body: message}
