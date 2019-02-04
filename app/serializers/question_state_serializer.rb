class QuestionStateSerializer < ActiveModel::Serializer
  attributes :id, :name, :question, :state

  def state
    object.state.slice(:id, :flow_id, :statable_type, :statable_id)
  end
end
