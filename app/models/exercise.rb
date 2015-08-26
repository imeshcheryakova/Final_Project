class Exercise < ActiveRecord::Base

  validates :exercise, :presence => true, :uniqueness => true
  validates :weather, :presence => true
  validates :calories_per_hour, :presence => true, numericality: { only_integer: true,  greater_than: 0, less_than: 4000 }
  has_many :recommendations , :class_name => "Recommendation", :foreign_key => "exercise_id"
  has_many :recommendations
  has_many :users_inputs

end
