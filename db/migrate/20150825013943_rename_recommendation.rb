class RenameRecommendation < ActiveRecord::Migration
  def change
    remove_column :recommendations, :recommendation_meal_portions
    rename_column :recommendations, :recommendation_time_exercise, :recommended_exercise_time
  end
end
