# frozen_string_literal: true

module Cryptocompare
  class TopCoinsByVolume
    def self.top_coins_string(volume_currency, length)
      client_response_body = top_coins_list(volume_currency, length).body
      JSON.parse(client_response_body)['Data'].map { |item| item['SYMBOL'] }.join(',')
    end

    def self.top_coins_list(volume_currency, length)
      Cryptocompare::Client.new.top_list(volume_currency, length)
    end
  end
end
