class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
  end

  def search_friend
    respond_to do |format|
      format.js {
        if !params[:friend].present?
          flash.now[:alert] = "Please enter a friend name or email to search"
          render partial: 'users/friend_result' and return
        end
  
        @friends = User.search(params[:friend])
        @friends = current_user.except_current_user(@friends)
  
        unless @friends.present?
          flash.now[:alert] = "Couldn't find user"
          render partial: 'users/friend_result' and return
        end
        
        render partial: 'users/friend_result'
      }
    end
  end
  
end
