class AddPollOptionIdToVotes < ActiveRecord::Migration
  def up
		add_column :votes, :poll_option_id, :integer
  end
  def down
		remove_column :votes, :poll_option_id
  end
end
