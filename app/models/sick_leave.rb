class SickLeave < ApplicationRecord
    belongs_to :user

    enum status: { pending: 0, approved: 1, rejected: 2 }

    after_initialize :set_default_status, if: :new_record?

    private 

    def set_default_status
        self.status ||= :pending 
    end
end
