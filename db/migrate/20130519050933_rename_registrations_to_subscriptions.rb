class RenameRegistrationsToSubscriptions < ActiveRecord::Migration
  def up
		rename_table :registrations, :subscriptions
  end

  def down
		rename_table :subscriptions, :registrations
  end
end
