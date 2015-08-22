class Meal < ActiveRecord::Base
  has_many :recommendations
  has_many :users_inputs
end
