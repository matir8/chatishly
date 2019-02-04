class StateSerializer < ActiveModel::Serializer
  attributes :id, :flow_id, :statable_type, :statable
end
