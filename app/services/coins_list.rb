class CoinsList
  def self.top_coins_prices(currency, length, cmc_api_key)
    top_coins_array = Cryptocompare::TopCoinsByVolume
                      .top_coins(currency, length)
    top_coins_symbols = top_coins_array.map { |coin| coin['SYMBOL'] }

    coins_data = Coinmarketcap::CoinsData.new(cmc_api_key)

    # Not all coins from Cryptocompare exist in Coinmarketcap,
    # we have to filter existing on both platforms.
    valid_coins_array = coins_data.valid_coins
    match_coins_array = valid_coins_array
                        .select { |coin| top_coins_symbols.include?(coin['symbol']) }
    match_coins_symbols = match_coins_array.map { |coin| coin['symbol'] }.uniq
    match_coins_symbols_string = match_coins_symbols.join(',')

    prices_array = coins_data.coins_prices(match_coins_symbols_string, currency)
                             .sort_by { |coin| coin['symbol'] }

    ranks_array = top_coins_array
                  .select { |coin| match_coins_symbols.include?(coin['SYMBOL']) }
                  .each_with_index { |coin, index| coin['rank'] = index + 1 }
                  .sort_by { |coin| coin['SYMBOL'] }
                  .map { |coin| coin.slice('rank') }

    prices_array.zip(ranks_array)
                .map { |pair| pair.last.merge(pair.first) }
                .sort_by { |coin| coin['rank'] }
  end
end
