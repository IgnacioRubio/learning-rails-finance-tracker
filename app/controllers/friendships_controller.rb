class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]
  
  def create
    current_user.friendships.build(friend_id: params[:friend_id])

    if current_user.save
      flash[:notice] = "Following friend"
    else
      flash[:alert] = "Cannot follow friend"
    end

    redirect_to my_friends_path
  end

  def destroy
    if @friendship.present? && @friendship.destroy
      flash[:notice] = "Stopped following"
    else
      flash[:alert] = "Cannot stop following"
    end

    redirect_to my_friends_path
  end

  private
  def set_friendship
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end
end
