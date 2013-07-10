class AddDetailsToRoom < ActiveRecord::Migration
  def change
  	add_column :rooms, :maximum_registrants, :integer
  end
end
