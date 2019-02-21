class Page < ApplicationRecord
  belongs_to :user
  belongs_to :bot, optional: true

  validates :facebook_id, presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true
  validates :category, presence: true
  validates :name, presence: true
end
