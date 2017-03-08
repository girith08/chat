class PrivateChatroomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @chatroom = Chatroom.new
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name, :visibility)
  end
end
