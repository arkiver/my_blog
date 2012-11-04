class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true
  property :content, Text, :required => true
  property :tag, String, :required => false
end
