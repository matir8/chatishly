class BotSession < ApplicationRecord
  belongs_to :current_state, class_name: 'State'
  has_one :flow, through: :current_state
  has_one :bot, through: :flow

  validates :sender_id, presence: true
end
