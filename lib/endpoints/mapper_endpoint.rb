require 'rubygems'
require 'wase_endpoint'
require 'open-uri'

class MapperEndpoint < WaseEndpoint

  def self.process(output, input1, input2)
    { 'TwitterList' => input1['TwitterList'].map{|id| id.to_s} }
  end
end
