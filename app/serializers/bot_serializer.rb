class BotSerializer < ActiveModel::Serializer
  attributes :id, :name, :default_flow, :list_flows_triggers, :page
end
