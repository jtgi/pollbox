class AddBlockedColumnToSubscriptions < ActiveRecord::Migration
  def up
		add_column :subscriptions, :blocked, :boolean, :default=>false
  end
	def down
		remove_column :subscriptions, :blocked
	end
end
