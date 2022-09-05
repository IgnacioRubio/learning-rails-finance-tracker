class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]
  
  def create
  end

  def destroy
    if @friendship.present? && @friendship.destroy
      flash[:notice] = "Stopped following"

      redirect_to my_friends_path
    else
      flash[:error] = "Cannot stop following"

      redirect_to my_friends_path
    end
  end

  private
  def set_friendship
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end
end
