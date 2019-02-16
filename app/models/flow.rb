class Flow < ApplicationRecord
  belongs_to :bot
  has_many :states

  validates :name, presence: true, uniqueness: true

  def start(session)
    ReplyWorker.perform_async(session.id)
  end

  def trigger_payload
    {
      name: name,
      type: 'Flow',
      payload: "TRIGGER_FLOW_#{id}_PAYLOAD"
    }
  end

  def list_states_triggers
    states.includes(:statable).collect do |state|
      {
        name: state.statable.name,
        type: 'State',
        payload: state.statable.trigger_payload
      }
    end
  end
end
