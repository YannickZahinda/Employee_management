class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reports
  has_many :meetings
  has_many :attendances
  has_many :holy_days
  has_many :sick_leaves, class_name: 'SickLeave'

  # enum role: { user: 0, admin: 1}

  # def admin?
  #   admin 
  # end
  
end
