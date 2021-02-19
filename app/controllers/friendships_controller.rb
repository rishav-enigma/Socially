class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user])
    friend = User.find(params[:friend])
    @friendship = Friendship.create(user_id: user.id, friend_id: friend.id)
  end

  def destroy
    user = User.find(params[:user])
    friend = User.find(params[:friend])
    friendship = Friendship.where(user_id: user.id, friend_id: friend.id).first_or_create
    inverse_friendship = Friendship.where(user_id: friend.id, friend_id: user.id).first_or_create
    friendship.destroy
    inverse_friendship.destroy
  end
end
