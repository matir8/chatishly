class FlowSerializer < ActiveModel::Serializer
  attributes :id, :bot_id, :name, :menu_action_title, :trigger_payload, :list_states_triggers
end
