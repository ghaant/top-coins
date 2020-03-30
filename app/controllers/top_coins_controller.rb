class TopCoinsController < ApplicationController
  def index
    if params[:cmc_api_key].nil?
      response.status = 406
      render(json: { message: 'Please provide your CoinmarketcapAPI key.' }) && return
    elsif params[:currency].nil?
      response.status = 406
      render(json: { message: 'Please input the coin price currency.', status: response.status }) && return
    elsif params[:limit].nil?
      response.status = 406
      render(json: { message: 'Please point out the limit.' }) && return
    end

    result = CoinsList.top_coins_prices(params[:currency], params[:limit], params[:cmc_api_key])
    render json: result
  end
end
