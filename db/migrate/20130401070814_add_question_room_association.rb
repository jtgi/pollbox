class AddQuestionRoomAssociation < ActiveRecord::Migration
  def up
	add_column :questions, :room_id, :integer
  end

  def down
	remove_column :questions, :room_id
  end
end
