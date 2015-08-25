class AddServingSizeToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :serving_size, :text
  end
end
