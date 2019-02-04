module Api::V1
  class StatesController < ApplicationController
    before_action :set_flow, only: %i[index show create update destroy]
    before_action :set_state, only: %i[show update destroy]
    before_action :set_statable, only: %i[create update]

    def index
      render json: @flow.states
    end

    def show
      render json: @state
    end

    def create
      @statable = @statable_class.new(@statable_params)

      if @statable.save
        @flow.states.create!(statable: @statable)
        render json: @statable
      else
        render json: { error: @statable.errors, status: 422 }
      end
    end

    def update
      @statable = @state.statable

      if @statable.update_attributes(@statable_params)
        render json: @statable
      else
        render json: { error: @statable.errors, status: 422 }
      end
    end

    def destroy
      render json: @state.destroy
    end

    private

    def set_flow
      @flow = Flow.find(state_params[:flow_id])
    end

    def set_state
      @state = @flow.states.find(state_params[:id])
    end

    def set_statable
      @statable_class = find_statable
      @statable_params = method(@statable_class.to_s.underscore << '_params').call
    end

    def find_statable
      type = state_params[:statable_type]
      type.classify.constantize
    rescue NameError
      raise ActionController::BadRequest.new, 'Invalid parameters'
    end

    def state_params
      params.permit(:id, :flow_id, :statable_type)
    end

    def text_state_params
      params.permit(:name, :text)
    end

    def image_state_params
      params.permit(:name, :url)
    end

    def open_graph_state_params
      params.permit(:name, :url)
    end

    def question_state_params
      params.permit(:name, :question)
    end
  end
end
