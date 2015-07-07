[
	'open-uri',
	'json',
	'yelp',
	'pp'
].each{|g|
	require g
}

require_relative 'helpers/methods.rb'

oauthHash = {
	consumer_key: ARGV[0],
	consumer_secret: ARGV[1],
	token: ARGV[2],
	token_secret: ARGV[3]
}
client = Yelp::Client.new(oauthHash)


File.open('zipCodes.txt','r').readlines[0..-1].each{|zipCode|
	zipCode = zipCode.strip
	yelpScanner(client, zipCode, 0)
}




## NON-API SCRAPING
# agent = Mechanize.new

# baseURL = 'http://www.yelp.com'
# searchURLPart = '/search'
# getParamsHash = {
# 	'find_loc' => 33401,
# 	'cflt' => 'nightlife'
# }
# getParamsString = getParamsHash.map{|pvPair|
# 	param = pvPair[0]
# 	val = pvPair[1]
# 	param+'='+val.to_s
# }.join('&')

# businessListingBaseURL = baseURL+searchURLPart+'?'+getParamsString

# puts agent.get(businessListingBaseURL).body