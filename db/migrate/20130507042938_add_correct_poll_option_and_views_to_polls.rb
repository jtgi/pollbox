class AddCorrectPollOptionAndViewsToPolls < ActiveRecord::Migration
  def up
		add_column :polls, :correct_poll_option_id, :integer
		add_column :polls, :views, :integer, :default=>0
  end
	def down
		remove_column :polls, :correct_poll_option_id
		remove_column :polls, :views
	end
end
