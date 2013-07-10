class AddPollIdToPollOption < ActiveRecord::Migration
  def up
		add_column :poll_options, :poll_id, :integer
  end
	def down
		remove_column :poll_options, :poll_id
	end
end
