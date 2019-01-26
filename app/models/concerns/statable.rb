module Statable
  extend ActiveSupport::Concern

  included do
    has_one :state, as: :statable
    has_one :flow, through: :state

    validates :name, presence: true

    def answer(session, message)
      send_message(session, message)

      Facebook::Messenger::Bot.on :message do |m|
        m.mark_seen
        m.typing_on

        yield m if block_given?
        m.typing_off
      end
    end

    def send_message(session, message)
      Facebook::Messenger::Bot
        .deliver({
                   recipient: { id: session.sender_id },
                   message: {
                     text: message
                   },
                   message_type: Facebook::Messenger::Bot::MessagingType::UPDATE
                 }, access_token: session.flow.bot.access_token)
    end
  end
end
