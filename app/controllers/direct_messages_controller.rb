class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    users = [current_user, User.find(params[:id])]
    @chatroom = Chatroom.direct_chat(users)
    @messages = @chatroom.messages.recent_messages
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
    render 'chatrooms/show'
  end
end
