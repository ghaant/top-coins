module Coinmarketcap
  class CoinsData
    def initialize(cmc_api_key)
      @client = Coinmarketcap::Client.new(cmc_api_key)
    end

    def valid_coins
      client_response = @client.valid_coins
      JSON.parse(client_response.body)['data']
    end

    def coins_prices(ids_string, currency)
      client_response = @client.coins_quotes(ids_string, currency)
      JSON.parse(client_response.body)['data'].map { |_key, value| value }
          .map { |coin| coin.slice('id', 'name', 'symbol', 'quote') }
          .each { |coin| coin['price'] = coin.delete('quote')[currency]['price'] }
    end
  end
end
