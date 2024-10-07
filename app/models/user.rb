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
  has_one_attached :id_card

  # validates :name, presence: true
  # validates :position, presence: true
  # validates :date_of_birth, presence: true
  # validates :sex, presence: true
  # validates :date_of_joining, presence: true
  # validate :id_card_format

  # enum role: { user: 0, admin: 1}

  # def admin?
  #   admin 
  # end
  
end
