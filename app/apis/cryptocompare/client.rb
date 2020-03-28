# frozen_string_literal: true

require './lib/cryptocompare/connection.rb'

module Cryptocompare
  class Client
    ENDPOINT = 'data/top/volumes'

    def top_list(volume_currency, length)
      params = {
        tsym: volume_currency,
        limit: length
      }

      get_request(params)
    end

    private

    def get_request(params)
      Cryptocompare::Connection.api.get(ENDPOINT, params)
    end
  end
end
