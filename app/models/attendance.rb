class Attendance < ApplicationRecord
    belongs_to :user
    # has_one_attached :qrcode, dependent: :destroy

    enum status: {absent: 0, present: 1}
end
