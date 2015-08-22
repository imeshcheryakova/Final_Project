class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :recommendation_meal_portions
      t.integer :recommendation_time_exercise
      t.integer :exercise_id
      t.integer :meal_id
      t.integer :user_id

      t.timestamps

    end
  end
end
