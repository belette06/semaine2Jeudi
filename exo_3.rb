require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_all_urls
  urls = []
  source = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
  page = Nokogiri::HTML(open(source))
  page.xpath('//ul[@class = "col3"]/li/a').each {|node| urls << node.values.join}
  return urls
end

def get_infos_deputy(url)
  root = "http://www2.assemblee-nationale.fr"
  page = Nokogiri::HTML(open("#{root}#{url}"))
  # E-mail scrapping
  email = page.xpath("//a[starts-with(@href, 'mailto')]")
  begin
    email = email.first.values.join[7..-1]
  rescue
    puts " Exception !!!"
    puts "No mail for this item"
  end
  # fullname scrapping
  fullname = page.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text
  firstname = fullname[1]
  lastname = fullname[2]
  puts "Datas ok for #{fullname}"
  datas = make_hash(email,fullname)
end

def make_hash(email, fullname)
  # take firstname and lastname from fullname
  firstname = fullname.split[1]
  lastname = fullname.split[2]
  # init keys and values
  keys = ["first_name", "last_name", "email"]
  values = [firstname, lastname, email]
  infos = Hash[keys.zip(values)]
end
def launch
  datas = []
  get_all_urls.each do |url|
    deputy = get_infos_deputy(url)
    datas << deputy
  end
  p datas
end

launch