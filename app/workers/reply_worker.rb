class ReplyWorker
  include Sidekiq::Worker

  def perform(session_id)
    @session = BotSession.find(session_id)
    @flow = @session.current_state.flow

    @session.current_state.statable.handle(@session)

    if next_state?
      next_index = @flow.states.index(@session.current_state) + 1
      @session.update(current_state: @flow.states.to_a.at(next_index))
    else
      @session.update(current_state: @flow.bot.default_flow.states.first)
    end
  end

  private

  def next_state?
    @session.current_state.id != @flow.states.last.id
  end
end
