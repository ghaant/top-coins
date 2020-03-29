# frozen_string_literal: true

module Coinmarketcap
  class CoinsData
    def initialize(cmc_api_key)
      @client = Coinmarketcap::Client.new(cmc_api_key)
    end

    def coins_ids_string(symbol_string)
      client_response = @client.currencies_ids(symbol_string)
      JSON.parse(client_response.body)['data'].map { |coin| coin['id'] }.join(',')
    end

    def coins_quotes(symbol_string, currency)
      ids_string = coins_ids_string(symbol_string)
      client_response = @client.currencies_quotes(ids_string, currency)
      JSON.parse(client_response.body)['data'].map { |_key, value| value }
          .map { |coin| coin.slice('id', 'name', 'symbol', 'quote') }
          .each { |coin| coin['price'] = coin.delete('quote')[currency]['price'] }

    end
  end
end
