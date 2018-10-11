require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_the_email_of_a_townhal_from_its_webpage(url)

	doc = Nokogiri::HTML(open(url))   
	doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

end
# take an url (string ), and return an email as a string
# p get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")


=begin
def get_the_email_of_a_townhal_from_its_webpage
    doc = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/vaureal.html'))
    return doc.css('.tr-last')[3].text.split(" ")[2]
end

puts get_the_email_of_a_townhal_from_its_webpage
=end


 def get_all_the_urls_of_val_doise_townhalls
	source = "http://annuaire-des-mairies.com/val-d-oise.html"
	url = []
	doc = Nokogiri::HTML(open(source))
	doc.xpath('//a[@class = "lientxt"]').each do |x|
		url << "http://annuaire-des-mairies.com#{x.values[1][1..-1]}"
	end
	 url
 end
 # take an htm (string ), and return an url as a string
 #puts get_all_the_urls_of_val_doise_townhalls


 def perform
	email_villes = Hash.new 
	get_all_the_urls_of_val_doise_townhalls.each do |url|
		email_villes = [get_the_email_of_a_townhal_from_its_webpage(url)]
puts email_villes
end
 end
 perform
