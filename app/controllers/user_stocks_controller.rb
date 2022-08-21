class UserStocksController < ApplicationController

  def create
    stock = Stock.find_or_create(params[:ticker])
    
    @user_stock = UserStock.create(user: current_user, stock: stock)

    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"

    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.find_by(user_id: current_user, stock_id: stock)
    if user_stock.destroy
      flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio"
      redirect_to my_portfolio_path
    else
      flash[:error] = "Something went wrong trying to remove #{stock.ticker} from your portfolio"
      redirect_to my_portfolio_path
    end
  end
  
end
