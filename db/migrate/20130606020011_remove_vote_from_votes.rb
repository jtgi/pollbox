class RemoveVoteFromVotes < ActiveRecord::Migration
  def up
    remove_column :votes, :vote
  end

  def down
    add_column :votes, :vote, :string
  end
end
