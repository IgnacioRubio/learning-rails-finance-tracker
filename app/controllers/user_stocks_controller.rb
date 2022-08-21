class UserStocksController < ApplicationController

  def create
    stock = Stock.find_or_create(params[:ticker])
    
    @user_stock = UserStock.create(user: current_user, stock: stock)

    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"

    redirect_to my_portfolio_path
  end
  
end
