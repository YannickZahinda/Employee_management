class Report < ApplicationRecord
    belongs_to :user
    has_many :attachments
    validate :title, presence: true
    validates :content, presence: true
    validates :report_type, presence: true
end
