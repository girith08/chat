class AddVisibilityToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :visibility, :string
  end
end
