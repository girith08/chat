module RoomsHelper
  def channel_name
    Chatroom.find(params[:id]).name
  end

  def channel_users
    Chatroom.find(params[:id]).users.map {|u| p u.email}.join(' , ') 
  end
end
