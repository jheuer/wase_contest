require 'rubygems'
require 'wase_endpoint'
require 'json'

class MassEndpoint < WaseEndpoint
  
  def self.process(output, input1, input2)
    followers = output['TwitterList']
    weight_by_country = input2['WeightbyCountry']
    
    # count followers by country_code
    follower_count_by_country = {}
    follower_country_codes = followers.collect{|f| f['country_code']}.uniq
    follower_country_codes.each do |country_code|
      follower_count_by_country[country_code] = followers.select{|f| f['country_code'] == country_code}.size
    end
    
    # calculate mass
    weight_by_country_code = JSON.parse(File.read('weight_by_country_code.json'))
    country_mean_weight_mean = weight_by_country_code.values.map{|v| v.to_f}.mean # calc average to fill in missing countries
    mass_by_country = follower_count_by_country.map do |country_code, count|
      country_mean_weight = weight_by_country_code[country_code] || country_mean_weight_mean
      country_mean_weight * count
    end
    output.merge({ 'mass_kgs' => mass_by_country.sum})
  end
  
  def self.dump_mapping
    country_codes = JSON.parse(File.read('country_codes.json'))
    weight_by_country = JSON.parse(File.read('WeightbyCountry.json'))['WeightbyCountry']
    country_code_mapping = JSON.parse(File.read('country_code_mapping.json'))
    
    weight_by_country_hash = {}
    weight_by_country.each{|g| weight_by_country_hash[g.keys.first] = g.values.first.to_f}
    
#    country_codes_master = {}
#    country_codes.each_pair do |code, name|
#      if weight_by_country_hash[name]
#        country_codes_master[code] = name
#      else
#        country_codes_master[code] = country_code_mapping[name]
#      end
#    end
#    File.open('country_codes_master.json', 'w') {|f| f.write country_codes_master.to_json}
    
    weight_by_country_code = {}
    country_codes.each_pair do |code, name|
      if weight_by_country_hash[name]
        weight_by_country_code[code] = weight_by_country_hash[name]
      else
        weight_by_country_code[code] = weight_by_country_hash[country_code_mapping_hash[name]]
      end
    end
    File.open('weight_by_country_code.json', 'w') {|f| f.write weight_by_country_code.to_json}
    
#    all_countries = country_codes.keys
#    ey_countries = weight_by_country.collect{|wbc| wbc.keys.first}.sort
#    (all_countries - ey_countries).sort.each{|c| p c}
#    (ey_countries - all_countries).sort.each{|c| p c}

#"Democratic Republic of the Congo"
#"Montenegro"
#"Republic of Korea"
#"Serbia"
#"The former Yugoslav Republic of Macedonia"
#"The former state union of Serbia and Montenegro"
#"West Bank and Gaza"
    
#    follower_count_by_country = Follower.count(:group => :country_code, :conditions => 'country_code is not null')
#    country_mean_weight_mean = master.values.map{|v| v.to_f}.mean # calc average to fill in missing countries
#    follower_count_by_country.map do |country_code, count|
#      p country_code
#      p country_mean_weight = master[country_code] || country_mean_weight_mean
#      p count
#      p country_mean_weight * count
#      p " "
#    end
#
#    # map from google to engine yard country names
#    country_name = case country.key
#      when 'Brunei' then 'Brunei Darussalam'
#      when 'North Korea' then 'Democratic People\'s Republic of Korea'
#      when 'Laos' then 'Lao People\'s Democratic Republic'
#      when 'Libya' then 'Libyan Arab Jamahiriya'
#      when 'Micronesia' then 'Micronesia (Federated States of)'
#      when 'Moldova' then 'Republic of Moldova'
#      when 'Russia' then 'Russian Federation'
#      when 'São Tomé and Príncipe' then 'Sao Tome and Principe'
#      when 'Syria' then 'Syrian Arab Republic'
#      when 'Macedonia' then 'The former Yugoslav Republic of Macedonia'
#      when 'South Korea' then 'Republic of Korea'
#      when 'Tanzania' then 'United Republic of Tanzania'
#      when 'Timor-Leste' then 'Democratic Republic of Timor-Leste'
#      when 'USA' then 'United States of America'
#      when 'Venezuela' then 'Venezuela (Bolivarian Republic of)'
#      when 'Vietnam' then 'Viet Nam'
#      when 'Serbia' then 'The former state union of Serbia and Montenegro'
#      when 'Montenegro' then 'The former state union of Serbia and Montenegro'
#      else country.key
#    end

    # EY missing: Anguilla, Aruba, Bermuda, Cayman Islands, Christmas Island, 
    # Cocos Islands, Cook Islands, Greenland, Hong Kong, Macau, 
    # Martinique, Netherlands Antilles, Reunion, Saint Helena, Taiwan,
    # Wallis Futana

    # EY has: French Polynesia, Georgia, West Bank and Gaza

    # EY has BOTH Congo, Democratic Republic of the Congo
    # both Ivory Coast


    # present in ey but not google
#    "Democratic Republic of the Congo"
#    "Montenegro"
#    "Serbia"
#    "South Korea"
#    "The former Yugoslav Republic of Macedonia"
#    "The former state union of Serbia and Montenegro"
#    "West Bank and Gaza"
  end


end

class Array
  def sum; inject{ |sum,x| sum ? sum+x : x }; end
  def mean; sum / size.to_f; end
end
