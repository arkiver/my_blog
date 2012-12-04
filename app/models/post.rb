class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :content, Text, :required => true
  property :tag, String, :required => false
  property :deleted, TinyInt, :default => 0
  property :created_at, DateTime, :lazy => true
  property :updated_at, DateTime, :lazy => true
end
