class FlickrService
  def initialize(api_key)
    @api_key = api_key
  end

  def search_photos(count)
  response = HTTParty.get("https://api.flickr.com/services/rest/", query: {
    method: 'flickr.photos.search',
    tags: 'bikerace, BoulderBikeTour',
    api_key: @api_key,
    format: 'json',
    nojsoncallback: 1,
    per_page: 40,
    page: 1
  })

  puts "Flickr API Raw Response: #{response.body}"

  puts "Flickr API Response: #{response.inspect}"

maxPages = 0

  if response && response.success?
    if response['stat'] == 'fail'
      puts "Flickr API Request Failed: #{response['message']}"
      return []
    end
  
maxPages = response['photos']['pages'] 

    photos = response['photos']['photo']
    photos&.map do |photo|
      {
        id: photo['id'],
        title: photo['title'],
        url: "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
      }
    end 
  else
    puts "Flickr API Response: #{response.inspect}"
    []
  end
  return {photos:photos, maxPages:maxPages}
end

end


