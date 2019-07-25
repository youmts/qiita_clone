FactoryBot.define do
  factory :article do
    title { "MyString" }
    body { "MyText" }
    tag_list { ["tag"] }
    status { :open }

    association :user
  end

  factory :user do
    name {"John"}
    sequence(:email) { |n| "test+#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
    tag_list { ["tag"] }
  end

  factory :comment do
    body { "MyText" }

    association :user
    association :article
  end
end