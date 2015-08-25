class AddContentToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :content, :text
  end
end
