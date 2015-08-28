class UsersInput < ActiveRecord::Base

  validates :exercise_time, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 360 }
  validates :meal, :presence => true
  validates :exercise_id, :presence => true
  validates :meal_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :exercise
  belongs_to :meal
  belongs_to :user
end
