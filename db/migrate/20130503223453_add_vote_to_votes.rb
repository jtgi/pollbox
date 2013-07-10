class AddVoteToVotes < ActiveRecord::Migration
  def up
		add_column :votes, :vote, :string
  end
  def down
		remove_column :votes, :vote
  end
end
