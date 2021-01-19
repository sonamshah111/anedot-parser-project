require 'nokogiri'
require 'open-uri' # Used to parse directly from URI instead of HTML string

$CRAIGLIST_URI = 'https://seattle.craigslist.org/search/cta?query=jeep'
#Method to calculate 8.9% tax on amount
def tax_amount(amount)
  return ((amount * 8.9)/100).round(2)
end

# to retrieve car title detail
def car_title(title_text,model_text)
	title = title_text.strip!
	title = title.gsub(model_text, "")
	return title
end

#to retrieve car model detail
def car_model(model_text)
  model = model_text.scan(/\b\d{4}\b/).first ? model_text.scan(/\b\d{4}\b/).first : ""
end

# to retrieve car price detail
def car_price(price_text)
	price = price_text.css('span.result-price').text
	price = price.gsub(/\D/,'').to_i
end

#to retrieve car listind date 
def car_listing_date(date_text)
	listing_date = Date.parse date_text.css('time')[0]['datetime']
	listing_date.to_s
end

craiglist_raw_html = Nokogiri::HTML.parse(open($CRAIGLIST_URI)) # Nokogiri::HTML.parse used for parsing directly from URL 

# Step3 : Parse https://seattle.craigslist.org/search/cta?query=jeep and print raw results
#print craiglist_raw_html 

# Step5: Print each item with Model Year - Date - Title 
puts "Model Year -  Date       -       Title " # Title header
100.times { print "-" }
puts
total = 0
craiglist_raw_html.css('div.result-info').each do |car_detail|
  title_text = car_detail.css('h3.result-heading').text
  car_price = car_price(car_detail)
  model = car_model(title_text)
  puts model + "       -  " + car_listing_date(car_detail) + " -    " + car_title(title_text,model)  #display Model year, Date and Title
  car_price = car_price(car_detail)
  total += car_price
	 end	
100.times { print "-" }
# Step6: Calculate 
puts 
puts "Sub Total:  $#{"%.2f" % total}" # total without tax 
puts "Tax: $#{"%.2f" % tax_amount(total)}" # taxable amount

puts "Total: $#{"%.2f" % (total + tax_amount(total))}" # total with tax
