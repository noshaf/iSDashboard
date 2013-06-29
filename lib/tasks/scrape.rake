task :scrape => :environment do 
  	source = Net::HTTP.get('sfbay.craigslist.org', '/tia/')
  	doc = Nokogiri::HTML(source)
  	doc.css(".row a").each do |row|
	  	path = row['href']
	  	source = Net::HTTP.get('sfbay.craigslist.org', path)
	  	doc = Nokogiri::HTML(source)
	  	doc.css("a").each_with_index do |link, index| 
			if link.text.match /@sale.craigslist.org/ do
				puts doc.css("a")[index].text
	   			end
	   		end
		end
  	end
end