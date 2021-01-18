require 'nokogiri'
require 'open-uri' # Used to parse directly from URI instead of HTML string

craiglist_raw_html = Nokogiri::HTML.parse(open('https://seattle.craigslist.org/search/cta?query=jeep')) # Nokogiri::HTML.parse used for parsing directly from URL 

# Step3 : Parse https://seattle.craigslist.org/search/cta?query=jeep and print raw results
#print craiglist_raw_html 

# Step4: Print each item with Date - Title 
puts "Date - Title"
craiglist_raw_html.css('div.result-info').each do |car_detail|
  date_info = Date.parse car_detail.css('time')[0]['datetime'] 
  puts date_info.to_s + " - " + car_detail.css('h3.result-heading').text
end	

