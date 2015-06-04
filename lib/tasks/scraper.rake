namespace :scraper do
  desc "Fetch Craigslist post from 3Taps"
  task scrape: :environment do

  	require 'open-uri'
	require 'JSON'

	#Set API token and URL
	auth_token = "968104a069364eba6a578a3016e696bf"
	polling_url = "http://polling.3taps.com/poll"

	#Specify request parameters
	params = {
		auth_token: auth_token,
		anchor: 2197874771,
		source: "CRAIG",
		category_group: "RRRR",
		category: "RHFR",
		'location.city' => "USA-NYM-BRL",
		retvals: "location,external_url,heading,body,timestamp,price,images,annotations"
	}

	#Prepare API Request

	uri = URI.parse(polling_url)
	uri.query = URI.encode_www_form(params)

	#Submit request
	result = JSON.parse(open(uri).read)

	#Display results to screen
	#puts result["postings"].first["location"]["locality"]

	#Store results in database
	result["postings"].each do |posting|

		#Create New Post
		@post = Post.new 
		@post.heading = posting["heading"]
		@post.body = posting["body"]
		@post.price = posting["price"]
		@post.neighborhood = posting["location"]["locality"]
		@post.external_url = posting["external_url"]
		@post.timestamp = posting["timestamp"]

		# Save Post
		@post.save 

	end 

  end

  desc "TODO"
  task destroy_all_posts: :environment do
  end

end
