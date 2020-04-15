class Post < ApplicationRecord
  belongs_to :user
  has_many :subnews, class_name: "Post",
           foreign_key: "repost_news_id"

  belongs_to :repost_news, class_name: "Post", optional: true
end
