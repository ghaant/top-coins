# frozen_string_literal: true

require './lib/coinmarketcap/connection.rb'

module Coinmarketcap
  class Client
    COMMON_PATH = 'v1/cryptocurrency/'
    IDS_PATH = 'map'
    QUOTES_PATH = 'quotes/latest'
    VALID_COINS_PATH = 'listings/latest'
    MAX_LIMIT = 5000

    def initialize(api_key)
      @header = {
        'X-CMC_PRO_API_KEY' => api_key
      }
    end

    def coins_ids(coins_string)
      endpoint = COMMON_PATH + IDS_PATH

      params = {
        'symbol': coins_string
      }

      get_request(endpoint, params)
    end

    def coins_quotes(ids_string, currency)
      endpoint = COMMON_PATH + QUOTES_PATH

      params = {
        'id': ids_string,
        'convert': currency
      }

      get_request(endpoint, params)
    end

    def valid_coins
      endpoint = COMMON_PATH + VALID_COINS_PATH

      # Without this parameter Coinmarketcap API by default retuns only 100 records.
      params = {
        'limit': MAX_LIMIT
      }

      get_request(endpoint, params)
    end

    private

    def get_request(endpoint, params)
      Coinmarketcap::Connection.api.get(endpoint, params, @header)
    end
  end
end
