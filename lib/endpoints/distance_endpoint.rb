require 'rubygems'
require 'wase_endpoint'
require 'geokit'

class DistanceEndpoint < WaseEndpoint
  # TODO: check
  RAILS_ORIGIN_POINT = { :lat => 41 + 54/60.0, :lng => 87 + 39/60.0 }
  
  def self.process(output, input1, input2)
    endpoint = output['centroid_lat_lng']

#    Geokit::default_units = :miles/:nms/:kms
#    Geokit::default_formula = :sphere/:flat

    point1 = Geokit::LatLng.new(RAILS_ORIGIN_POINT[:lat], RAILS_ORIGIN_POINT[:lng])
    point2 = Geokit::LatLng.new(endpoint[:lat], endpoint[:lng])
    output.merge({ 'distance_kms' => point1.distance_to(point2, :units => :kms, :formula => :sphere) })
  end
end
