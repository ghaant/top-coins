# frozen_string_literal: true

module Cryptocompare
  class Connection
    API_BASE = 'https://min-api.cryptocompare.com'

    def self.api
      Faraday.new(API_BASE) do |faraday|
        faraday.response :logger
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
