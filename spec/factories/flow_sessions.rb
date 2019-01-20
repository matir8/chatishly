FactoryBot.define do
  factory :flow_session do
    sender_id { "MyString" }
    flow { nil }
    current_state { nil }
    next_state { nil }
  end
end
