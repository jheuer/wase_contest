require 'rubygems'
require 'wase_endpoint'
require 'geokit'
require 'json'

class GeocoderEndpoint < WaseEndpoint
  
  USE_CACHE = true

  def self.process(output, input1, input2)
    followers = output['TwitterList']
    
    if USE_CACHE
      follower_geolocations = JSON.parse(File.read('follower_geolocations.json'))
    else
      Geokit::Geocoders::google = JSON.parse(File.read('google_key.json'))
    end    
    
    result = followers.map do |f|
      if USE_CACHE
        if geo = follower_geolocations[f['location']]
          {
            'id' => f['id'],
            'location' => f['location'],
            'lat' => geo['lat'],
            'lng' => geo['lng'],
            'country_code' => geo['country_code']
          }
        else
          { 'id' => f, 'location' => f['location'], 'lat' => nil, 'lng' => nil, 'country_code' => nil }
        end
      else
#        @logger.info "Geocoding: #{f['location']}"
        if f['location']
          geo = Geokit::Geocoders::GoogleGeocoder.geocode(f['location'])
          {
            'id' => f['id'],
            'location' => f['location'],
            'lat' => geo['lat'],
            'lng' => geo['lng'],
            'country_code' => geo['country_code']
          }
        else
          { 'id' => f, 'location' => f['location'], 'lat' => nil, 'lng' => nil, 'country_code' => nil }
        end
      end
    end
    
    { 'TwitterList' => result }
  end
end
