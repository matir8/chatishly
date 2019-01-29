class Flow < ApplicationRecord
  belongs_to :bot

  has_many :flow_sessions

  has_many :states
  has_many :text_states, through: :states, source: :statable, source_type: 'TextState', class_name: 'TextState'
  has_many :question_states, through: :states, source: :statable, source_type: 'QuestionState', class_name: 'QuestionState'

  validates :name, presence: true, uniqueness: true

  def start(session)
    ReplyWorker.perform_async(session.id)
  end

  def trigger_payload
    "TRIGGER_FLOW_#{id}_PAYLOAD"
  end

  def list_states_triggers
    states.includes(:statable).collect { |state| state.statable.trigger_payload }
  end
end
