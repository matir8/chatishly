class State < ApplicationRecord
  belongs_to :flow
  belongs_to :statable, polymorphic: true

  has_many :quick_replies
end
