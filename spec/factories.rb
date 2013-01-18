FactoryGirl.define do
  factory :post do |post|
    post.title "Test post title"
    post.content "Test post content"
    post.created_at DateTime.now
    post.updated_at DateTime.now
  end
end
