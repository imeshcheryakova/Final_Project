class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true, :uniqueness => true
  validates :zip, :presence => true, numericality: { only_integer: true }
  validates :state, :presence => true
  validates :city, :presence => true
  validates :unit, :presence => true
  validates :street, :presence => true

  validates :alcohol, :presence => true, numericality: { only_integer: true }
  validates :body, :presence => true
  validates :height, :presence => true, numericality: { only_integer: true }
  validates :weight, :presence => true, numericality: { greater_than: 80, less_than: 500 }
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :activity_factor, :presence => true, numericality: { greater_than: 0, less_than: 2}
  validates :target_days, :presence => true, numericality: { greater_than: 0, less_than: 365 }
  validates :target_pounds, :presence => true, numericality: { greater_than: -50, less_than: 50 }

  has_many :recommendations
  has_many :users_inputs
end
