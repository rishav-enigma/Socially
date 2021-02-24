require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context "validation tests" do
    it "should save successfully" do
      user = User.create(name: "test2212 kumar", username:"test112", email: "test1232@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      friendship = Friendship.new(user_id: user.id, friend_id: friend1.id).save
      expect(friendship).to eq(true)
    end
  
    it "ensures user presence" do
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      friendship = Friendship.new(user_id: nil, friend_id: friend1.id)
      expect(friendship).to_not be_valid
    end

    it "ensures friend presence" do
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      friendship = Friendship.new(user_id: friend1.id, friend_id: nil)
      expect(friendship).to_not be_valid
    end

    it "ensures user uniqueness for same friend" do
      user = User.create(name: "test2212 kumar", username:"test112", email: "test1232@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      friendship = Friendship.new(user_id: friend1.id, friend_id: user.id).save
      friendship2 = Friendship.new(user_id: friend1.id, friend_id: user.id)
      expect(friendship2).to_not be_valid
    end
  end

  context "method tests" do
    it "check is_mutual is true" do
      user = User.create(name: "test2212 kumar", username:"test112", email: "test1232@example.com", password: "test123", password_confirmation: "test123")
      friend1 = User.create(name: "friend1", username:"friend2", email: "firend2@example.com", password: "test123", password_confirmation: "test123")
      friendship = Friendship.new(user_id: friend1.id, friend_id: user.id).save
      friendship2 = Friendship.create(user_id: user.id, friend_id: friend1.id)
      expect(friendship2.is_mutual).to eq(true)
    end
  end
end
