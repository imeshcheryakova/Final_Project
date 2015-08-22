class Exercise < ActiveRecord::Base
  has_many :recommendations , :class_name => "Recommendation", :foreign_key => "exercise_id"
  has_many :recommendations
  has_many :users_inputs

end
