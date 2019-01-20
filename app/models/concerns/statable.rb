module Statable
  extend ActiveSupport::Concern

  included do
    has_one :state, as: :statable
    has_one :flow, through: :state

    validates :name, presence: true

    def answer
      Facebook::Messenger::Bot.on :message do |message|
        message.mark_seen
        message.typing_on

        yield message

        message.typing_off
      end
    end
  end
end
