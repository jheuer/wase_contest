require 'rubygems'
require 'wase_endpoint'

class BearingEndpoint < WaseEndpoint
  
  RAILS_ORIGIN_POINT = { :lat => 41 + 54/60.0, :lng => 87 + 39/60.0 }

  def self.process(output, input1, input2)
    endpoint = output['centroid_lat_lng']

    # http://www.movable-type.co.uk/scripts/latlong.html
    y = Math.sin(endpoint['lat'] - RAILS_ORIGIN_POINT[:lat]) * Math.cos(endpoint['lat'])
    x = Math.cos(RAILS_ORIGIN_POINT[:lat]) * Math.sin(endpoint['lat']) - 
      Math.sin(RAILS_ORIGIN_POINT[:lat]) * Math.cos(endpoint['lat']) * Math.cos(endpoint['lng'] - 
      RAILS_ORIGIN_POINT[:lng])
    
    output.merge({ 'bearing_degrees' => (Math.atan2(y,x) / (2 * Math::PI)) * 360 })
  end
end
