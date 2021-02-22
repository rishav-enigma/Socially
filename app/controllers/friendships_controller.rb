class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:user])
    @friend = User.find(params[:friend])
    @friendship = Friendship.new(user_id: @user.id, friend_id: @friend.id)
    if @friendship.save
      flash.now[:notice] = "You are friends with " + @friend.username
      respond_to do |format|
        format.js
        format.html { redirect_to users_index_path, alert: "User added succesfully"  }
      end
    else
      flash.now[:danger] = "Error occurred. Please refresh and try again"
    end
  end

  def destroy
    @user = User.find(params[:user])
    @friend = User.find(params[:friend])
    friendship = Friendship.where(user_id: @user.id, friend_id: @friend.id).first_or_create
    inverse_friendship = Friendship.where(user_id: @friend.id, friend_id: @user.id).first_or_create
    friendship.destroy
    inverse_friendship.destroy
    flash.now[:danger] = "You removed " + @friend.username
    respond_to do |format|
      format.js
      format.html { redirect_to users_index_path, alert: "User removed succesfully" }
    end
  end
end
