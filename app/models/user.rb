class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true
  validates :zip, :presence => true, numericality: { only_integer: true }
  validates :state, :presence => true
  validates :city, :presence => true
  validates :unit, :presence => true
  validates :street, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :alcohol, :presence => true, numericality: { only_integer: true }
  validates :password, :presence => true, :uniqueness => { :scope => :username }
  validates :body, :presence => true
  validates :height, :presence => true, numericality: { only_integer: true }
  validates :weight, :presence => true, numericality: { only_integer: true }
  validates :first_name, :presence => true
  validates :last_name, :presence => true


  has_many :recommendations
  has_many :users_inputs
end
