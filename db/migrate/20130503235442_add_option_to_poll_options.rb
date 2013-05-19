class AddOptionToPollOptions < ActiveRecord::Migration
  def up
		add_column :poll_options, :option, :string
  end
  def down
		remove_column :poll_options, :option
  end
end
