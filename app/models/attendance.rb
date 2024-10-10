class Attendance < ApplicationRecord
    belongs_to :user
    # has_one_attached :qrcode, dependent: :destroy

    enum status: {absent: 0, present: 1}

    validates :worked_hours, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :present?
end
