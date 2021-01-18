require 'nokogiri'
require 'open-uri' # Used to parse directly from URI instead of HTML string

craiglist_raw_html = Nokogiri::HTML.parse(open('https://seattle.craigslist.org/search/cta?query=jeep')) # Nokogiri::HTML.parse used for parsing directly from URL 

# Step3 : Parse https://seattle.craigslist.org/search/cta?query=jeep and print raw results
print craiglist_raw_html 
