class BotSerializer < ActiveModel::Serializer
  attributes :id, :name, :page_id, :default_flow, :list_flows_triggers
end
