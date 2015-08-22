class Dropcolumn < ActiveRecord::Migration
  def change
    remove_column :users_inputs, :exercise_type
  end
end
