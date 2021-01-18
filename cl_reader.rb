require 'nokogiri'
require 'open-uri' # Used to parse directly from URI instead of HTML string

craiglist_raw_html = Nokogiri::HTML.parse(open('https://seattle.craigslist.org/search/cta?query=jeep')) # Nokogiri::HTML.parse used for parsing directly from URL 

# Step3 : Parse https://seattle.craigslist.org/search/cta?query=jeep and print raw results
#print craiglist_raw_html 

# Step5: Print each item with Model Year - Date - Title 
puts "Model Year -  Date       -       Title"
100.times { print "-" }
print "\n"
craiglist_raw_html.css('div.result-info').each do |car_detail|
  date_info = Date.parse car_detail.css('time')[0]['datetime'] 
  model = car_detail.css('h3.result-heading').text.scan(/\b\d{4}\b/).first ? car_detail.css('h3.result-heading').text.scan(/\b\d{4}\b/).first : ""
  title = car_detail.css('h3.result-heading').text.strip! #removing extra space in title
  puts model + "       -  " + date_info.to_s + " -    " + title.gsub(model, "")
 end	

