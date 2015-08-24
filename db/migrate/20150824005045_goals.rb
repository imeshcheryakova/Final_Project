class Goals < ActiveRecord::Migration
  def change
    add_column(:users, :target_pounds,:decimal)
    add_column(:users, :target_days,:decimal)
  end
end
