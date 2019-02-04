class QuickReplySerializer < ActiveModel::Serializer
  attributes :id, :content_type, :title, :payload, :image_url, :state_id
end
