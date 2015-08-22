class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :weather
      t.integer :calories_per_hour
      t.string :type

      t.timestamps

    end
  end
end
