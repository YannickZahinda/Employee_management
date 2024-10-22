class Report < ApplicationRecord
    belongs_to :user
    has_many_attached :attachments
  
    validates :title, presence: true
    validates :content, presence: true
    validates :report_type, presence: true
  
    def attachment_type(attachment)
      case attachment.content_type
      when /^image\//
        :image
      when /^video\//
        :video
      when /^application\/pdf/
        :pdf
      else
        :file
      end
    end
  end
  