class Meal < ActiveRecord::Base

  validates :meal, :presence => true
  validates :calories_per_portion, :presence => true, numericality: { only_integer: true,  greater_than: 0, less_than: 4000 }
  validates :serving_size, :presence => true
  validates :content, :presence => true
  has_many :recommendations
  has_many :users_inputs
end
