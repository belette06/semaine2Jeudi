require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


def cryptomonaie(url)

crypto_array = []
price_array = []

    page = Nokogiri::HTML(open(url))
    cryptos = page.css('td').select { |link| link['class'] == 'no-wrap currency-name' }
    prices = page.css('a').select { |link| link['class'] == 'price' }

    cryptos.each {|link| crypto_array.push link['data-sort']}
    prices.each { |link| price_array.push link['data-usd']}
    
	crypto_hash = Hash[crypto_array.zip(price_array)]
puts crypto_hash

end

cryptomonaie("https://coinmarketcap.com/all/views/all/")
