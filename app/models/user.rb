class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes
  has_many :products
  has_many :reviews
  has_many :orders

  validates :name, presence: true  
  validates :email, presence: true
  validates :password, presence: true
  validates :age, presence: true
  validates :address, presence: true
  validates :mobile_number, presence: true
end
