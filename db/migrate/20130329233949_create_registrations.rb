class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :room_id
      t.integer :user_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
