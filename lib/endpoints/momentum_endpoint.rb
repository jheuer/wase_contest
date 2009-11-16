require 'rubygems'
require 'wase_endpoint'

class MomentumEndpoint < WaseEndpoint

  def self.process(output, input1, input2)
    momentum_text = <<TEXT
Rails Momentum is #{output['mass_kgs']} kilograms per meter per second with a bearing of #{output['bearing_degrees']} degrees. 
Its current location is latitude #{output['centroid_lat_lng']['lat']} and longitude #{output['centroid_lat_lng']['lng']}
TEXT

    output.merge({ 'momentum_text' => momentum_text })
  end
end
