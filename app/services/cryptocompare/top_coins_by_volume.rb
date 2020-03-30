# frozen_string_literal: true

module Cryptocompare
  class TopCoinsByVolume
    def self.top_coins_list(volume_currency, length)
      JSON.parse(Cryptocompare::Client.new.top_list(volume_currency, length).body)['Data']
          .select { |coin| coin['ID'].to_i.positive? } # For some reason the result includes coins with a negatie sign, e.g. XBTUSD, for which Coinmarketcap API returns an error.
    end
  end
end
