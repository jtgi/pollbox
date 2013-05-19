class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do |t|

      t.timestamps
    end
  end
end
