task :test_mail => :environment do 
	send_emails([], "ben_instastub")
end

task :scrape_houston => :environment do 
	puts "Compiling Emails..."
	emails = scrape("houston.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "biteski")
	puts "~100 Emails sent to houston area"
end

task :scrape_phili => :environment do 
	puts "Compiling Emails..."
	emails = scrape("philadelphia.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "biteski")
	puts "~100 Emails sent to Phili area"
end

task :scrape_sf => :environment do 
	puts "Compiling Emails..."
	emails = scrape("sfbay.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "littlebite")
	puts "~100 Emails sent to SF area"
end

task :scrape_ny => :environment do
	puts "Compiling Emails..."
  	emails = scrape("newyork.craigslist.org")
	puts "Sending Emails through lavabit..."
  	send_emails(emails, "littlebite")
	puts "~100 Emails sent to NY area"
end

task :scrape_jacksonville => :environment do 
	puts "Compiling Emails..."
	emails = scrape("miami.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "picobyte")
	puts "~100 Emails sent to Jacksonville area"
end

task :scrape_chicago => :environment do 
	puts "Compiling Emails..."
	emails = scrape("chicago.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "ben_instastub")
	puts "~100 Emails sent to Chicago area"
end

task :scrape_la => :environment do
	puts "Compiling Emails..."
	emails = scrape("losangeles.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "ben_instastub")
	puts "~100 Emails sent to LA area"
end

task :scrape_phoenix => :environment do
	puts "Compiling Emails..."
	emails = scrape("phoenix.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "jason_instastub")
	puts "~100 Emails sent to Phoenix area"
end

task :scrape_austin => :environment do
	puts "Compiling Emails..."
	emails = scrape("austin.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "jason_instastub")
	puts "~100 Emails sent to Ausin area"
end

task :scrape_seattle => :environment do
	puts "Compiling Emails..."
	emails = scrape("seattle.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "tinybit")
	puts "~100 Emails sent to Seattle area"
end

task :scrape_denver => :environment do
	puts "Compiling Emails..."
	emails = scrape("denver.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "tinybit")
	puts "~100 Emails sent to Denver area"
end

task :scrape_boston => :environment do
	puts "Compiling Emails..."
	emails = scrape("boston.craigslist.org")
	puts "Sending Emails through lavabit..."
	send_emails(emails, "picobyte")
	puts "~100 Emails sent to Boston area"
end

def scrape(area)
  	emails = []
	source = Net::HTTP.get(area, '/tix/')
  	doc = Nokogiri::HTML(source)
  	doc.css(".row a.i").each do |row|
	  	path = row['href']
	  	source = Net::HTTP.get(area, path)
	  	doc = Nokogiri::HTML(source)
	  	doc.css("a").each_with_index do |link, index| 
			link.text.match /@sale.craigslist.org/ do
				email = doc.css("a")[index].text
				emails << email
	   		end
		end
  	end
  	emails
end

def send_emails(emails, username)

	email_text = "Hi, I work for a company that is trying to make buying and selling tickets
through social mediums easier.

Feel free to try our product for free.

Visit this link, http://goo.gl/YYVSZp and use the code 'VIP'.

If you have any questions please let me know.

Best,
Jason"

	cl_emails = emails << "9rq7d-3976269214@sale.craigslist.org" 

	agent = Mechanize.new
	agent.user_agent_alias = 'Linux Mozilla'
	page = agent.get 'https://lavabit.com/apps/webmail/src/login.php'

	# #log into gmail
	form = page.forms.first
	form.login_username = username
	form.secretkey = 'gracefulbreeze'
	page = agent.submit(form, form.buttons.first)

	page = agent.click page.frames[1]

	cl_emails.each do |email|
		page = agent.click page.links.find { |l| l.text =~ /compose/i }

		form = page.forms.first

		form.send_to = email

		form.subject = 'Selling your tickets'

		form.body = email_text

		page = agent.submit(form, form.buttons[1])
	end
end
