class BotSerializer < ActiveModel::Serializer
  attributes :id, :name, :default_flow, :list_flows_triggers, :page

  def page
    page = Page.find_by(facebook_id: object.page_id)
    {
      name: page.name,
      id: page.facebook_id
    }
  end
end
