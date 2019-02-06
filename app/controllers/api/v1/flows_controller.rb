module Api::V1
  class FlowsController < ApiController
    before_action :set_bot
    before_action :set_flow, except: %i[index create]

    def index
      render json: @bot.flows
    end

    def show
      render json: @flow
    end

    def create
      @flow = Flow.new(flow_params)

      if @flow.save
        render json: @flow
      else
        render json: { error: @flow.errors, status: 422 }
      end
    end

    def update
      if @flow.update_attributes(flow_params)
        render json: @flow
      else
        render json: { error: @flow.errors, status: 422 }
      end
    end

    def destroy
      render json: @flow.destroy
    end

    def trigger_payload
      render json: { trigger_payload: @flow.trigger_payload }
    end

    def list_states_triggers
      render json: { states_triggers: @flow.list_states_triggers }
    end

    private

    def set_bot
      @bot = current_user.bots.find(flow_params[:bot_id])
    end

    def set_flow
      @flow = @bot.flows.find(flow_params[:id])
    end

    def flow_params
      params.permit(:id, :bot_id, :name, :menu_action_title)
    end
  end
end
