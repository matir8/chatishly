class BotSessionSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :current_state_id
end
