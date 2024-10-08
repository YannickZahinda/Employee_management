class Attendance < ApplicationRecord
    belongs_to :user

    enum status: {absent: 0, present: 1}
end
