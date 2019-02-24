module Api::V1
  class BotsController < ApiController
    before_action :set_bot, except: %i[index create]
    before_action :set_page, only: %i[create update]

    def index
      render json: current_user.bots
    end

    def show
      render json: @bot
    end

    def create
      @bot = Bot.new(
        name: bot_params[:name],
        user_id: current_user.id,
        page_id: @page.id,
        verify_token: ENV['facebook_verify_token']
      )

      if @bot.save
        @page.update_attributes(bot_id: @bot.id)
        render json: @bot
      else
        render json: { error: @bot.errors }, status: 422
      end
    end

    def update
      if params[:default_flow_id]
        @bot.update(default_flow_id: bot_params[:default_flow_id])
      end

      @bot.update(
        name: bot_params[:name],
        page_id: @page.id
      )

      if @bot.save
        @page.update_attributes(bot_id: @bot.id)
        render json: @bot
      else
        render json: { error: @bot.errors }, status: 422
      end
    end

    def destroy
      render json: @bot.destroy
    end

    def subscribe
      render json: @bot.subscribe_bot
    end

    def configure_persistent_menu
      render json: @bot.configure_persistent_menu(bot_params[:menu])
    end

    def delete_persistent_menu
      render json: @bot.delete_persistent_menu
    end

    def bot_sessions
      render json: BotSession.includes(:bot).where(bots: { id: @bot.id })
    end

    def broadcast
      broadcasts = bot_session_params[:broadcasts]

      broadcasts.each do |curr_broadcast|
        flow = @bot.flows.find(curr_broadcast[:flow_id])
        session = BotSession.find(curr_broadcast[:session_id])

        session.update(current_state_id: flow.states.first.id)
        flow.start(session)
      end
    end

    def recipient_info
      render json: @bot.recipient_info(bot_params[:sender_id])
    end

    private

    def bot_params
      params.permit(:name, :id, :bot_id, :page_id, :sender_id, :default_flow_id,
                    menu: [
                      :locale,
                      :composer_input_disabled,
                      call_to_actions: %i[title type payload]
                    ])
    end

    def bot_session_params
      params.permit(:id, :bot_id, broadcasts: %i[flow_id session_id])
    end

    def set_bot
      id = bot_params[:id] || bot_params[:bot_id]
      @bot = current_user.bots.find(id)
    end

    def set_page
      @page = Page.find(bot_params[:page_id])
    end
  end
end
