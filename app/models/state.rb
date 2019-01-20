class State < ApplicationRecord
  belongs_to :flow
  belongs_to :statable, polymorphic: true
end
