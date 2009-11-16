require 'rubygems'
require 'wase_endpoint'
require 'open-uri'
require 'json'

class TwittterEndpoint < WaseEndpoint
  
  USE_CACHE = true

  def self.process(output, input1, input2)
    twitter_ids = output['TwitterList']
    follower_locations = JSON.parse(File.read('follower_locations.json'))
    result = twitter_ids.map do |twitter_id|
      if USE_CACHE
        location = follower_locations[twitter_id]
      else
        location = JSON.parse(open("http://twitter.com/users/show/#{twitter_id}.json").read)['location']
      end
      
      { 
        'id' => twitter_id, 
        'location' => location
      }
    end

    { 'TwitterList' => result }
  end
end
