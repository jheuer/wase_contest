require 'rubygems'
require 'wase_endpoint'

class BitlyEndpoint < WaseEndpoint

  def secret_sauce(raw_json)
    return { :increment => -1 } unless raw_json[:method] && raw_json[:url]
    
    data = case raw_json[:method]
      when 'shorten'
        Bitly.shorten(raw_json[:url])
      when 'expand'
        Bitly.expand(raw_json[:url])
      when 'info'
        Bitly.info(raw_json[:url])
      when 'stats'
        Bitly.stats(raw_json[:url])
      else
        # error
        return { :increment => -1 }
    end
    { :data => data }
  end
end
