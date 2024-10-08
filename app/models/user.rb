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

  # before_commit :generate_qrcode, on: :create

  # private 

  # def generate_qrcode
  #   # Get the host 
  #   host = Rails.application.routes.default_url_options[:host] || 'localhost:3000'    # Create the qrcode object 
  #   qr_code = RQRCode::QRCode.new(user_url(self, host: host))
  #   # create the PNG object 
  #   png = qrcode.as_png(
  #     bit_depth: 1,
  #     border_modules: 4,
  #     color_mode: ChunkyPNG::COLOR_GRAYSCALE,
  #     color: "black",
  #     file: nil,
  #     fill: "white",
  #     module_px_size: 6,
  #     resize_exactly_to: false,
  #     resize_gte_to: false,
  #     size: 120
  #   )
  #   self.qr_code.attach(
  #     io.StringIO.new(png.to_s),
  #     filename: 'qr_code.png',
  #     content_type: "image/png"
  #   )
  # end




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
