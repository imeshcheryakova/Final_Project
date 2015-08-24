class ActivityFactor < ActiveRecord::Migration
  def change
      add_column(:users, :activity_factor,:decimal)
  end
end
