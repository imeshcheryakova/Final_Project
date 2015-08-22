class CreateUsersInputs < ActiveRecord::Migration
  def change
    create_table :users_inputs do |t|
      t.integer :exercise_time
      t.string :exercise_type
      t.integer :exercise_id
      t.integer :meal_id
      t.integer :user_id

      t.timestamps

    end
  end
end
