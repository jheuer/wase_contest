require 'rubygems'
require 'wase_endpoint'

class SpeedEndpoint < WaseEndpoint
  
  RAILS_ORIGIN_DATE = Date.parse('December 14th, 2005')

  def self.process(output, input1, input2)
    elapsed_days = DateTime.now - RAILS_ORIGIN_DATE
    elapsed_secs = elapsed_days * 24 * 60 * 60
    output.merge({ 'speed_meters_per_sec' => output['distance_kms'] * 1000 / elapsed_secs.to_f })
  end
end
