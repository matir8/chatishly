module Api::V1
  class BotsController < ApiController
    before_action :set_bot, only: %i[show update destroy subscribe]

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
        page_id: bot_params[:page_id],
        access_token: access_token,
        verify_token: ENV['facebook_verify_token']
      )

      if @bot.save
        render json: @bot
      else
        render json: { error: @bot.errors, status: 422 }
      end
    end

    def update
      @bot.update(
        name: bot_params[:name],
        page_id: bot_params[:page_id]
      )

      if @bot.save
        render json: @bot
      else
        render json: { error: @bot.errors, status: 422 }
      end
    end

    def destroy
      render json: @bot.destroy
    end

    def subscribe
      render json: @bot.subscribe_bot
    end

    private

    def bot_params
      params.permit(:name, :id, :bot_id, :page_id)
    end

    def set_bot
      id = bot_params[:id] || bot_params[:bot_id]
      @bot = Bot.find(id)
    end

    def access_token
      # Important: If we use the facebook_pages method here to get the pages,
      #            their access_tokens will update.

      result = User.find(current_user.id).pages.select do |page|
        page.facebook_id == bot_params[:page_id]
      end
      result.first.access_token
    end
  end
end