class BotSessionSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :progress, :sender_profile_pic, :sender_name, :last_active

  def progress
    {
      state: {
        id: object.current_state.id,
        name: object.current_state.statable.name
      },
      flow: {
        id:  object.current_state.flow.id,
        name: object.current_state.flow.name
      }
    }
  end

  def last_active
    object.updated_at
  end
end
