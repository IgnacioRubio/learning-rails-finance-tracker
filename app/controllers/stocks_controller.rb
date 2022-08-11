class StocksController < ApplicationController

  def search
    respond_to do |format|
      format.js {
        if !params[:stock].present?
          flash.now[:alert] = "Please enter a symbol to search"
          render partial: 'users/result' and return
        end
  
        @stock = Stock.new_lookup(params[:stock])
  
        if @stock.nil?
          flash.now[:alert] = "Symbol enter not found"
          render partial: 'users/result' and return
        end
        
        render partial: 'users/result'
      }
    end
  end

end