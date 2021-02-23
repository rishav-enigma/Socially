require 'rails_helper'

RSpec.describe Post, type: :model do
  context "validation tests" do
    current_user = User.first_or_create!(email: "testuser@test.com", name: "test user",
                      username: "test.kumar", password: "password", password_confirmation: "password")
    
    it "is a valid Post" do
      post = Post.new( content: "Valid Content", user: current_user, visibility: 1)
      expect(post).to be_valid
    end

    it "has content" do
      post = Post.new( content: "", user: current_user, visibility: 1)
      expect(post).to_not be_valid
    end
    
    it "has content length less than equal 250" do
      post = Post.new( content: "a"*251, user: current_user, visibility: 1)
      expect(post).to_not be_valid
    end

    it "has content length atleast 2" do
      post = Post.new( content: "a", user: current_user, visibility: 1)
      expect(post).to_not be_valid
    end

    it "has default visibility everyone" do
      post = Post.new( content: "Valid", user: current_user)
      expect(post.visibility).to eq("personal")
    end

    it "has wrong visibility" do
      expect{Post.new( content: "Valid", user: current_user, visibility: 3)}.to raise_error(ArgumentError)
    end
  end
end
