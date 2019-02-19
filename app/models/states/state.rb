class State < ApplicationRecord
  belongs_to :flow
  belongs_to :statable, polymorphic: true, dependent: :destroy

  has_many :quick_replies, dependent: :destroy
end
