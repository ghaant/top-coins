# frozen_string_literal: true

module Coinmarketcap
  class Connection
    API_BASE = 'https://pro-api.coinmarketcap.com'

    def self.api
      Faraday.new(API_BASE) do |faraday|
        faraday.response :logger
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
        faraday.headers['Accept'] = 'application/json'
      end
    end
  end
end
