class AddValidCodeToSubscriptions < ActiveRecord::Migration
  def change
		add_column :subscriptions, :valid_access_code, :boolean, :default=>true
  end
end
