module Statable
  extend ActiveSupport::Concern

  included do
    has_one :state, as: :statable
    has_one :flow, through: :state

    validates :name, presence: true

    def answer(session, text)
      message = demo_message(text)
      send_message(session, message)
    end

    def send_message(session, message)
      Facebook::Messenger::Bot
        .deliver({
                   recipient: { id: session.sender_id },
                   message: message,
                   message_type: Facebook::Messenger::Bot::MessagingType::UPDATE
                 }, access_token: session.flow.bot.access_token)
    end

    private

    def demo_message(message)
      {
        text: message,
        quick_replies: [
          {
            content_type: 'text',
            title: 'Sample flow',
            payload: 'TRIGGER_SAMPLE_FLOW_PAYLOAD'
          }
        ]
      }
    end
  end
end
