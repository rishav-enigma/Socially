require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validation tests" do
    user = User.first_or_create!(email: "testuser@test.com", name: "test user",
      username: "test.kumar", password: "password", password_confirmation: "password")
    post = Post.new(content: "Don't pass comments", user: user)
    it "is a valid comment" do
      comment = Comment.new(content: "Passed comment", post: post, user: user)
      expect(comment).to be_valid
    end
    
    it "has content" do
      comment = Comment.new(content: "", post: post, user: user)
      expect(comment).to_not be_valid
    end
    
    it "has content length less than equal 250" do
      comment = Comment.new( content: "a"*251, user: user, post: post)
      expect(comment).to_not be_valid
    end

    it "has content length atleast 2" do
      comment = Comment.new( content: "a", user: user, post: post)
      expect(comment).to_not be_valid
    end

    it "has user" do
      comment = Comment.new(post: post, user: nil)
      expect(comment).to_not be_valid
    end

    it "has post" do
      comment = Comment.new(post: nil, user: user)
      expect(comment).to_not be_valid
    end

  end
end
