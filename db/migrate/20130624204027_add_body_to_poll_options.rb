class AddBodyToPollOptions < ActiveRecord::Migration
  def change
    add_column :poll_options, :body, :string
  end
end
