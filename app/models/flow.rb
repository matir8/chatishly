class Flow < ApplicationRecord
  belongs_to :bot

  has_many :flow_sessions

  has_many :states
  belongs_to :default_state, class_name: 'TextState', foreign_key: 'default_state_id'
  has_many :text_states, through: :states, source: :statable, source_type: 'TextState', class_name: 'TextState'
  has_many :question_states, through: :states, source: :statable, source_type: 'QuestionState', class_name: 'QuestionState'

  validates :name, presence: true

  def start(message)
    session = flow_session(message)
    ReplyWorker.perform_async(session.id)
  end

  def trigger_payload
    "TRIGGER_#{name.delete(' ').upcase}_FLOW_PAYLOAD"
  end

  private

  def flow_session(message)
    session = flow_sessions.find_by(sender_id: message.sender['id'])

    if session.nil?
      session = FlowSession.create!(
        sender_id: message.sender['id'],
        flow_id: id,
        current_state_id: states.first.id
      )
    end

    session
  end
end
