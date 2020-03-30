module Cryptocompare
  class TopCoinsByVolume
    def self.top_coins(volume_currency, length)
      JSON.parse(Cryptocompare::Client.new.top_list(volume_currency, length).body)['Data']
    end
  end
end
