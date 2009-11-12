require 'rubygems'
require 'open-uri'
require 'net/http'
require 'twitter'
require 'json'

class WASE
  
  INPUT_PERSISTENCE_ENDPOINT = 'http://radiant-rain-94.heroku.com/data_snippets'

  def self.run(message)
    message_hash = WASE.parse_message message
    p message_hash
    listing_json = open('http://' + message_hash[:listing_uri]).read
    p listing = JSON.parse(listing_json)
    input1_json = open('http://' + message_hash[:input_uri1]).read
    p input1 = JSON.parse(input1_json)
    input2_json = open('http://' + message_hash[:input_uri2]).read
    p input2 = JSON.parse(input2_json)
    
    result = 1 # TODO
    
    data_url = WASE.store_data_snippet(1)
    bitly_data_url = Bitly.shorten(data_url)
    
    WASE.put_output(message_hash[:output_uri], result)
    
    WASE.send_message(message_hash) if message_hash[:listing][message_hash[:counter]+1]
  end
  
  def self.check_for_messages
    # TODO
  end
  
  def self.store_data_snippet(data)
    res = Net::HTTP.post_form(URI.parse(INPUT_PERSISTENCE_ENDPOINT), { 'data_snippet[body]' => data })
    raise "Data snippet creation failed" unless res.code == '302'
    res.header['location']
  end
  
  def self.put_output(url, output)
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      headers = {'Content-Type' => 'text/plain; charset=utf-8'}
      response = http.send_request('PUT', uri.request_uri, output, headers)
      p "Response #{response.code} #{response.message}: #{response.body}"
    end
  end
  
  def self.send_message(message)
    # TODO
  end
  
  def self.parse_message(message)
    # So the message format of a WASTE message is: 
    # [WASEpoint], [WASE hashtag] [Program Counter (0 initially)], [Program listing URI], [Unix Timestamp], 
    # [Output URI] [,Input URI (optional)] [, Input URI 2 (optional)]
  
    if message =~ /\A(@.+) (#wase,)? (\d+), (.*bit\.ly\/\w+), (\d+), (bit\.ly\/\w+)(, (bit\.ly\/\w+)(, (bit\.ly\/\w+))?)?\z/im
      return {
        :wasepoint => $1, 
        :counter => $3, 
        :listing_uri => $4, 
        :timestamp => $5, 
        :output_uri => $6, 
        :input_uri1 => $9, 
        :input_uri2 => $10
      }
    else
      return false
      # TODO
#      WASE.raise_error()
    end
  end
  
  def self.raise_error
    WASE.send_message "#TODO"
  end
end

class Bitly
  BITLY_API_VERSION = '2.0.1'
  BITLY_API_LOGIN   = 'twitchboard'
  BITLY_API_KEY     = 'R_da534e03d74e8099bb8b7993b6387194'
  
  def self.shorten(long_url)
    JSON.parse(make_request(:shorten, { 'longUrl' => long_url }))['results'][long_url]['shortUrl']
  end

  def self.expand(short_url)
    JSON.parse(make_request(:expand, { 'shortUrl' => short_url }))['results'][bitly_hash]['longUrl']
  end
  
  def self.make_request(method, params, login => BITLY_API_LOGIN, api_key => BITLY_API_KEY, version => BITLY_API_VERSION)
    params = params.collect{ |p| CGI::escape(p[0]) + '=' + CGI::escape(p[1]) }.join('&')
    open("http://api.bit.ly/#{method}?version=#{version}&#{params}&login=#{login}&apiKey=#{api_key}").read
  end
end

class Twittter
  
end

WASE.run "@ey-sort #wase, 0, api.bit.ly/errors, 1256850843, bit.ly/2uhGcl, bit.ly/3kl0xs, bit.ly/3kl0xt"