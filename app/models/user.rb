class User < ApplicationRecord
  require 'rqrcode'

  # Include default devise modules. Others available are:
  include Rails.application.routes.url_helpers 
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :reports
  has_many :meetings
  has_many :attendances
  has_many :holy_days
  has_many :sick_leaves, class_name: 'SickLeave'
  has_one_attached :qr_code
  has_one_attached :id_card
  has_one_attached :avatar

  after_validation :geocode_last_sign_in_ip, if: -> (obj) {obj.saved_change_to_current_sign_in_ip? || obj.saved_change_to_last_sign_in_ip?}

  geocoded_by :last_sign_in_ip

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


  # private 

  def geocode_last_sign_in_ip!
    # return if geocode_last_sign_in_ip.blank?
    ip = self.current_sign_in_ip || self.last_sign_in_ip

     Rails.logger.debug "Started Geocoding for IP $$$$$$$$$$$$$$$: #{ip}"

    return if ip.blank? || ip == "::1" || ip == "127.0.0.1"

    begin 

      result = Geocoder.search(ip)

       Rails.logger.debug "Geocoder RESULT $$$$$$$$$$$$$$$: #{result.inspect}"

       location = result.first 

      if location 
         Rails.logger.debug "FOUND LOCATION:::: $$$$$$$$$$$$$$$: #{location.inspect}"

         location_string = [
          location.city,
          location.state,
          location.country
        ].compact.reject(&:empty?).join(', ')
        
        updates = {
          last_known_location: location_string,
          latitude: location.latitude,
          longitude: location.longitude
        }

        # self.last_known_location = [location.city, location.country].compact.join(', ')
        # self.latitude = location.latitude
        # self.longitude = location.longitude

        Rails.logger.debug "Updating with: $$$$$$$$$$$$$$$    #{updates.inspect}"
        update(updates)

      else
        Rails.logger.warn "No location found for IP $$$$$$$$$$$: #{ip}"
      end 


    rescue => e
      Rails.logger.error "Geocoding error: #{e.message}"
    end
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
