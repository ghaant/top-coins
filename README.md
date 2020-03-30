# TOP COINS

This is an API intended for listing top N cryptocurrencies with the biggest direct volumes in the provided currency along with their prices in the same currency. As the sources of data are used:
* cryptocompare API - for getting the list of currencies with max direct volumes,
* coinmarketcap API - for getting prices of the currencies from the list above.

Coinmarketcap API requires a personal API key, so before running the application make sure you get this key from their webpage.

The required parameters of the application are follows:
1. cmc_api_key - Coinmarketcap API key,
2. currency - a currency of volume and price of cryptocurrencies,
3. limit - the number of listed cryptocurrencies (max = 1000).

Calling template: <host_address>?currency=USD&limit=10&cmc_api_key=<your_personal_api_key>
