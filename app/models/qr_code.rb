class QrCode < ApplicationRecord
  # belongs_to :user
  # has_one_attached :image 

  # before_create :generate_code 
  # after_create :generate_image

  # private 

  # def generate_code 
  #   self.code = SecureRandom.uuid 
  # end

  # def generate_image
  #   qr = RQRCode::QRCode.new(self.code)
  #   png = qr.as_png(size: 300)

  #   self.image_attach(
  #     io: StringIO.new(pn.to_s),
  #     filename: "qr_code_#{self.id}.png",
  #     content_type: 'image/png'
  #   )
  # end

end
