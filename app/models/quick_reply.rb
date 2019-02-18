class QuickReply < ApplicationRecord
  validates :content_type, presence: true
  validates :title, presence: true
  validates :payload, presence: true

  belongs_to :state
end
