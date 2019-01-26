class ReplyWorker
  include Sidekiq::Worker

  def perform(session_id)
    @session = FlowSession.find(session_id)
    @flow = Flow.find(@session.flow_id)

    @session.current_state.statable.handle(@session)

    next_index = if next_state?
                   @flow.states.index(@session.current_state) + 1
                 else
                   0
                 end

    @session.update(current_state: @flow.states.to_a.at(next_index))
  end

  private

  def next_state?
    @session.current_state.id != @flow.states.last.id
  end
end
