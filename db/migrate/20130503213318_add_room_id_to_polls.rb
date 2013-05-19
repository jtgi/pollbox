class AddRoomIdToPolls < ActiveRecord::Migration
  def up
		add_column :polls, :room_id, :integer
  end
	def down
		remove_column :polls, :room_id
	end
end
