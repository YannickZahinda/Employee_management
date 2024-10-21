class User < ApplicationRecord
  require 'rqrcode'

  # Include default devise modules. Others available are:
  include Rails.application.routes.url_helpers 
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reports
  has_many :meetings
  has_many :attendances
  has_many :holy_days
  has_many :sick_leaves, class_name: 'SickLeave'
  has_one_attached :qr_code
  has_one_attached :id_card

  def total_worked_hours 
    attendances.where(status: :present).sum(:worked_hours)
  end

  def calculate_performance_metrics(start_date = 30.days.ago, end_date = Date.today)
    start_date = start_date.to_date
    end_date = end_date.to_date
    
    relevant_attendances = attendances.where(date: start_date..end_date)

    total_days = (end_date - start_date).to_i
    days_present = relevant_attendances.where(status: :present).count
    total_hours_worked = relevant_attendances.sum(:worked_hours) #a verifier ! ! ! !

    attendance_rate = (days_present.to_f / total_days) * 100 
    average_daily_hours = total_hours_worked / days_present if days_present > 0

    {
      total_days: total_days,
      days_present: days_present,
      total_hours_worked: total_hours_worked,
      attendance_rate: attendance_rate, 
      average_daily_hours: average_daily_hours
    }

  end

  def performance_analysis
    PerformanceAnalyzerService.new(self).analyze 
  end


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
