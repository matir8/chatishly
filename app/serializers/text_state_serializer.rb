class TextStateSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :state

  def state
    object.state.slice(:id, :flow_id, :statable_type, :statable_id)
  end
end
