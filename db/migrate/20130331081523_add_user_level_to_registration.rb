class AddUserLevelToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :user_level, :integer, :default=>0
  end
end
