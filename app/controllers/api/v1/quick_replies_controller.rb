module Api::V1
  class QuickRepliesController < ApplicationController
    before_action :set_state, only: :index
    before_action :set_quick_reply, only: %i[show update destroy]

    def index
      render json: @state.quick_replies
    end

    def show
      render json: @quick_reply
    end

    def create
      @quick_reply = QuickReply.new(quick_reply_params)

      if @quick_reply.save
        render json: @quick_reply
      else
        render json: { error: @quick_reply.errors, status: 422 }
      end
    end

    def update
      if @quick_reply.update_attributes(quick_reply_params)
        render json: @quick_reply
      else
        render json: { error: @quick_reply.errors, status: 422 }
      end
    end

    def destroy
      render json: @quick_reply.destroy
    end

    private

    def set_state
      @state = State.find(quick_reply_params[:state_id])
    end

    def set_quick_reply
      @quick_reply = QuickReply.find(quick_reply_params[:id])
    end

    def quick_reply_params
      params.permit(:id, :state_id, :content_type, :title, :payload, :image_url)
    end
  end
end
