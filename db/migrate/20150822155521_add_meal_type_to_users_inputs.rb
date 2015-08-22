class AddMealTypeToUsersInputs < ActiveRecord::Migration
  def change
    add_column :users_inputs, :meal_type, :text
  end
end
