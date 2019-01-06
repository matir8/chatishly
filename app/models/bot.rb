class Bot < ApplicationRecord
  belongs_to :user

  validates :verify_token, presence: true
  validates :app_secret, presence: true
  validates :access_token, presence: true
end
