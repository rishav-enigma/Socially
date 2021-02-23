require 'rails_helper'

RSpec.describe Like, type: :model do
  context "validation tests" do
    user = User.first_or_create!(email: "testuser@test.com", name: "test user",
      username: "test.kumar", password: "password", password_confirmation: "password")
    post = Post.new(content: "Don't pass likes", user: user)

    it "is a valid like" do
      like = Like.new(post: post, user: user)
      expect(like).to be_valid
    end

    it "has user" do
      like = Like.new(post: post, user: nil)
      expect(like).to_not be_valid
    end

    it "has post" do
      like = Like.new(post: nil, user: user)
      expect(like).to_not be_valid
    end

  end
end
