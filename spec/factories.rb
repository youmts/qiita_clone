FactoryBot.define do
  factory :article do
    title { "MyString" }
    body { "MyText" }
    user { nil }
  end

  factory :user do
    name {"John"}
    email {"test@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end