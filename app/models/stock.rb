class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true
  validates :ticker, uniqueness: true
  
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_cloud[:publishable_token],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    begin
      new(
        ticker: ticker_symbol, 
        name: client.company(ticker_symbol).company_name, 
        last_price: client.price(ticker_symbol)
      )
    rescue => exception
      nil
    end
  end

  def self.find_or_create(ticker_symbol)
    stock = Stock.find_by(ticker: ticker_symbol)

    if stock.nil?
      stock = Stock.new_lookup(ticker_symbol)
      stock.save unless stock.nil?
    end

    stock
  end

end
