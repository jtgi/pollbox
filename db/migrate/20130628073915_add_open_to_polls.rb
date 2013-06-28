class AddOpenToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :open, :boolean, :default=>false
  end
end
