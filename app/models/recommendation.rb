class Recommendation < ActiveRecord::Base
  belongs_to :exercise , :class_name => "Exercise", :foreign_key => "exercise_id"
  belongs_to :exercise
  belongs_to :meal
  belongs_to :user
end
