class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_chatroom

  def create
    message = @chatroom.messages.new(message_params)
    message.user = current_user
    message.save
    MessageRelayJob.perform_later(message)
  end

  private

  def load_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:content).merge(user: current_user)
  end
end
