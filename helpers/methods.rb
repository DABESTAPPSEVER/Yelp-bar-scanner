def yelpScanner(client, zipCode, offset)
	params = {
		category_filter: 'nightlife',
		offset: offset
	}
	response = client.search(zipCode, params)
	responseJSON = response.to_json
	responseHash = JSON.parse(responseJSON)

	p "SEARCHING #{params[:category_filter]} IN #{zipCode}"
	businessesArray = responseHash['businesses']
	if(businessesArray.length===0)
		return false
	end

	businessesArray.each{|business|
		closed = business['is_closed']
		if(closed!=false)
			next
		end

		name = business['name'] # DATAPOINT
		phone = business['phone'] # DATAPOINT
		displayPhone = business['display_phone'] # DATAPOINT
		categoriesArray = business['categories'] # DATAPOINT
		categoriesArray.each{|categoryArray|
			category = categoryArray[0] # DATAPOINT
			categoryCode = categoryArray[1] # DATAPOINT
		}
		yelpId = business['id'] # DATAPOINT
		locationInfo = business['location']
		street = locationInfo['address'][0] # DATAPOINT
		city = locationInfo['city'] # DATAPOINT
		state = locationInfo['state_code'] # DATAPOINT
		country = locationInfo['country_code'] # DATAPOINT
		coordinateHash = locationInfo['coordinate']
		
		if(coordinateHash===nil)
			return false 
		end
		latitude = coordinateHash['latitude'] # DATAPOINT
		longitude = coordinateHash['longitude'] # DATAPOINT

		pp name
	}

	# sleep 2
	yelpScanner(client, zipCode, offset+=20)
end