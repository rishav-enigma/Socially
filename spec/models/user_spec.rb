require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it "should save successfully" do
      user = User.new(name: "test2212 kumar", username:"test112", email: "test1232@example.com", password: "test123", password_confirmation: "test123").save
      expect(user).to eq(true)
    end

    it "ensures name presence" do
      user = User.new(username:"test", email: "test@example.com", password: "test123", password_confirmation: "test123")
      expect(user).to_not be_valid
    end
    
    it "ensures username presence" do
      user = User.new(name:"test", email: "test@example.com", password: "test123", password_confirmation: "test123")
      expect(user).to_not be_valid
    end

    it "ensures email presence" do
      user = User.new(username:"test", name: "test1", password: "test123", password_confirmation: "test123")
      expect(user).to_not be_valid
    end

    it "ensures password presence" do
      user = User.new(name:"test", email: "test@example.com", username: "test123")
      expect(user).to_not be_valid
    end

    it "ensures username uniqueness" do
      user1 = User.new(name: "test kumar", username:"test", email: "test@example.com", password: "test123", password_confirmation: "test123").save
      user2 = User.new(name: "test2 kumar", username:"test", email: "test2@example.com", password: "test123", password_confirmation: "test123")
      expect(user2).to_not be_valid
    end

    it "ensures email uniqueness" do
      user1 = User.new(name: "test kumar", username:"test", email: "test@example.com", password: "test123", password_confirmation: "test123").save
      user2 = User.new(name: "test2 kumar", username:"testw", email: "test@example.com", password: "test123", password_confirmation: "test123")
      expect(user2).to_not be_valid
    end

    it "ensures email format" do
      user = User.new(name: "test", username:"test", email: "test", password: "test123", password_confirmation: "test123")
      expect(user).to_not be_valid
    end
  end

  context "method tests" do
    it "changes friend_requests by 1" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      expect { Friendship.create(user_id: friend1.id, friend_id: user.id) }.to change{ user.reload.friend_requests.count }.by(1)
    end
    
    it "changes active_friends by 1" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      expect do
        Friendship.create(user_id: friend1.id, friend_id: user.id) 
        Friendship.create(user_id: user.id, friend_id: friend1.id) 
      end.to change{ user.reload.active_friends.count }.by(1)
    end

    it "changes pending_friends by 1" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      expect do
        Friendship.create(user_id: user.id, friend_id: friend1.id) 
      end.to change{ user.reload.pending_friends.count }.by(1)
    end

    it "changes public_posts by 1" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      expect do
        friend1.posts << Post.new(content: "Some content", visibility: 2)
      end.to change{ user.reload.public_posts.count }.by(1)
    end

    it "changes feed by 1" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      expect do
        Friendship.create(user_id: user.id, friend_id: friend1.id) 
        Friendship.create(user_id: friend1.id, friend_id: user.id) 
        friend1.posts << Post.new(content: "Some content", visibility: 2)
        friend1.posts << Post.new(content: "Some content", visibility: 1)
        user.posts << Post.new(content: "Some content", visibility: 0)
      end.to change{ user.reload.feed.count }.by(3)
    end

    it "check if like post" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      post = Post.new(content: "Some content", visibility: 2)
      like = Like.new(post_id: post.id, user_id: user.id)
      friend1.posts << post
      post.likes << like
      expect(user.reload.likes?(post)).to eq(true)
    end

    it "should search user" do
      user = User.create(name: "test5", username:"test8", email: "test8@example.com", password: "test123", password_confirmation: "test123")
      expect(User.search("test8")).to include(user)
    end
  end
end
