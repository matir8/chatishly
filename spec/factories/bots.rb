FactoryBot.define do
  factory :bot do
    verify_token { "MyString" }
    app_secret { "MyString" }
    access_token { "MyString" }
    user { nil }
  end
end
