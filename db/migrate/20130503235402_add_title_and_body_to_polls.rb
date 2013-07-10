class AddTitleAndBodyToPolls < ActiveRecord::Migration
  def up
		add_column :polls, :title, :string
		add_column :polls, :body, :string
  end
  def down
		remove_column :polls, :title
		remove_column :polls, :body
  end
end
