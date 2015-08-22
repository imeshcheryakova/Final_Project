class RenameExercisesType < ActiveRecord::Migration
  def change

        rename_column :exercises, :type, :exercise
        rename_column :meals, :type, :meal
        rename_column :users, :bodytype, :body
        rename_column :users_inputs, :meal_type, :meal
  end
end
