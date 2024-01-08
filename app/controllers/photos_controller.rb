class PhotosController < ApplicationController
  def index
    # Initialize the FlickrService with your API key
    flickr_service = FlickrService.new('effbc0592cbc99c5d535ccd5df83e424')
    # Fetch photos from the FlickrService
data = flickr_service.search_photos(40)
photos_data = data[:photos]
maxPages = data[:maxPages] 
puts "Photos Data from FlickrService: #{photos_data.inspect}"

    # Add this line to inspect the structure of the first photo
    # Rails.logger.debug "First photo data: #{photos_data.first.inspect}"

    # Rails.logger.debug "Photos Data from Flickr API: #{photos_data.inspect}"

    @photos = photos_data.map do |photo|
      Rails.logger.debug "Processing photo: #{photo.inspect}"

      # Assign default values if any field is missing
      farm = photo['farm'] || 'default_farm'
      server = photo['server'] || 'default_server'
      id = photo['id'] || 'default_id'
      secret = photo['secret'] || 'default_secret'

      begin
        # Construct the photo URL with available or default data
        photo_url = "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}.jpg"
        Rails.logger.debug "Constructed photo URL: #{photo_url}"

        # Set a default title if the title is not present or is empty.
        title = photo['title'].presence || 'No Title Available'
        Rails.logger.debug "Mapped photo: { title: #{title}, url: #{photo_url} }"
        
        # Return the photo hash
        { title: title, url: photo_url }
      rescue => e
        Rails.logger.error "Error processing photo: #{e.message}"
        next # Skip to the next photo if an error occurs
      end
    end.compact # Remove any nil entries if a photo was skipped

    Rails.logger.debug "Final Photos Data: #{@photos.inspect}"

    # Respond to the request with HTML or JSON
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
end
















