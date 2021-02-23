require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it "should save successfully" do
      user = User.new(name: "test kumar", username:"test", email: "test@example.com", password: "test123", password_confirmation: "test123").save
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
end
