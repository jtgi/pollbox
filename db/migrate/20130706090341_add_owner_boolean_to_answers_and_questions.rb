class AddOwnerBooleanToAnswersAndQuestions < ActiveRecord::Migration
  def change
    add_column :answers, :admin, :boolean, :default=>false
    add_column :questions, :admin, :boolean, :default=>false
  end
end
