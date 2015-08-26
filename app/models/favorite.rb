class Favorite < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :exercise_id, :presence => true

  belongs_to :user
  belongs_to :exercise
end
