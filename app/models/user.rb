class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
         
  validates_presence_of :name, message: 'debe contener algo' 
  validates_uniqueness_of :name, message: 'nombre ya tomado'
end
