class FlowSession < ApplicationRecord
  belongs_to :flow
  belongs_to :current_state, class_name: 'State'

  validates :sender_id, presence: true
end
