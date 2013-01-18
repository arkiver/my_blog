require 'spec_helper'
post = FactoryGirl.build(:post)
describe Post do
  describe "should have valid" do
    it "title" do
      post.title = nil
      post.should_not be_valid
      post.title = "Test title"
      post.should be_valid
    end
  end
end
