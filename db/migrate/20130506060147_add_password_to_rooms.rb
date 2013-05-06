class AddPasswordToRooms < ActiveRecord::Migration
  def up
		add_column :rooms, :password_encrypted, :string, :limit=>128
  end
  def down
		remove_column :rooms, :password_encrypted
  end
end
