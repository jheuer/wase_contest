require 'rubygems'
require 'wase_endpoint'

class CentroidEndpoint < WaseEndpoint
  
  EARTH_RADIUS_IN_KMS = 6360

  # see http://en.wikipedia.org/wiki/Spherical_coordinate_system
  # this algorithm treats the earth as perfectly spherical, which is not perfectly accurate
  def self.process(output, input1, input2)
    points = output['TwitterList'].reject{|t| t['lat'].nil? || t['lng'].nil?}
    
    # convert lat/lng to cartesian coordinates
    cartesian_points = points.map{|t| spherical_to_cartesian(t['lat'], t['lng'])}
    
    # find centroid
    mean_xyz = cartesian_points.transpose.map(&:mean)
    
    # project centroid point out to surface of the earth
    centroid_vector_length = Math.sqrt(mean_xyz[0]**2 + mean_xyz[1]**2 + mean_xyz[2]**2)
    surface_xyz = mean_xyz.map{ |m| m / centroid_vector_length.to_f }
    
    # now convert cartesian coordinates back into lat/lng
    lat, lng = cartesian_to_spherical(surface_xyz[0], surface_xyz[1], surface_xyz[2])
    
    output.merge({ 'centroid_lat_lng' => { 'lat' => lat, 'lng' => lng } })
  end
  
  def self.spherical_to_cartesian(lat, lng)
    r = EARTH_RADIUS_IN_KMS
    inclination = ((180 - lat) * Math::PI) / 360.0
    azimuth = (lng * Math::PI) / 360.0
    x = r * Math.sin(inclination) * Math.cos(azimuth)
    y = r * Math.sin(inclination) * Math.sin(azimuth)
    z = r * Math.cos(inclination)
    [x,y,z]
  end
  
  def self.cartesian_to_spherical(x, y, z)
    inclination = Math.acos(z / (Math.sqrt(x**2 + y**2 + z**2)))
    azimuth = Math.atan2(y, x)
    lat = 180 - ((inclination * 360) / Math::PI)
    lng = (azimuth * 360) / Math::PI
    [lat,lng]
  end
end

class Array
  def sum; inject{ |sum,x| sum ? sum+x : x }; end
  def mean; sum / size.to_f; end
end