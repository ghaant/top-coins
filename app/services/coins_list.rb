class CoinsList
  def self.top_coins_prices(currency, length, cmc_api_key)
    coins_string = Cryptocompare::TopCoinsByVolume
                   .top_coins_string(currency, length)

    prices_array = Coinmarketcap::CoinsData.new(cmc_api_key)
                                           .coins_prices(coins_string, currency)
                                           .sort_by { |coin| coin['symbol'] }

    ranks_array = Cryptocompare::TopCoinsByVolume
                  .top_coins_list(currency, length)
                  .each_with_index { |coin, index| coin['rank'] = index + 1 }
                  .sort_by { |coin| coin['SYMBOL'] }
                  .map { |coin| coin.slice('rank') }

    prices_array.zip(ranks_array)
                .map { |pair| pair.last.merge(pair.first) }
                .sort_by { |coin| coin['rank'] }
  end
end
