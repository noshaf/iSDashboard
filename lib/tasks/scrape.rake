task :scrape => :environment do 
  	source = Net::HTTP.get('sfbay.craigslist.org', '/tix/')
  	doc = Nokogiri::HTML(source)
  	doc.css(".row a.i").each do |row|
	  	path = row['href']
	  	source = Net::HTTP.get('sfbay.craigslist.org', path)
	  	doc = Nokogiri::HTML(source)
	  	emails = []
	  	doc.css("a").each_with_index do |link, index| 
			link.text.match /@sale.craigslist.org/ do
				email = doc.css("a")[index].text
				emails << email
	   		end
		end
		emails.each do |email|
			puts email
		end
  	end
end