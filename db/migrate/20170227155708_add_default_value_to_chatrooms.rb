class AddDefaultValueToChatrooms < ActiveRecord::Migration[5.0]
  def change
    change_column_default :chatrooms, :visibility, 'public'
  end
end
