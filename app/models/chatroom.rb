class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :messages, dependent: :destroy

  scope :public_channels, -> { where(direct_message: false).where(visibility: 'public') }
  scope :direct_messages, -> { where(direct_message: true) }
  scope :private_channels, -> { where(visibility: 'private') }
  scope :private_and_public_channels, -> { where('visibility = ? or visibility = ?', 'public', 'private') }

  def self.direct_chat(users)
    user_ids = users.map(&:id).sort
    name = "DM:#{user_ids.join(':')}"

    if chatroom = direct_messages.where(name: name).first
      chatroom
    else
      chatroom = new(name: name, direct_message: true)
      chatroom.users = users
      chatroom.save
      chatroom
    end
  end

  def self.private_chat(users, name)
    name = name.to_s

    if chatroom = private_channels.where(name: name).first
      chatroom.users << users
      chatroom
    else
      chatroom = new(name: name, visibility: 'private')
      chatroom.users = users
      chatroom.save
      chatroom
    end
  end
end