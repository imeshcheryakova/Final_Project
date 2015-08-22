class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :calories_per_portion
      t.string :type

      t.timestamps

    end
  end
end
