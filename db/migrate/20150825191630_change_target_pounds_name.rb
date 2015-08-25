class ChangeTargetPoundsName < ActiveRecord::Migration
  def change
    rename_column :users, :target_pounds, :weight_target
  end
end
