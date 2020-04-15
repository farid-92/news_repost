FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    author { nil }
    repost_news { nil }
  end
end
