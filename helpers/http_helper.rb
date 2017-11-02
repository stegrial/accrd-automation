require 'net/http'
require 'uri'
require 'rubygems'
require 'json'

# Helper for HTTP requests
module HTTPHelper
  def self.get_body(user)
    file_name = case user
                when 'Пользователь 3' then 'U_M0KVS_without_client.json'
                when 'Пользователь 4' then 'U_M0SJH.json'
                when 'Пользователь 5' then 'U_M066X.json'
                when 'Пользователь 6' then 'u_m0w63_accr.json'
                else puts 'Error'
                end

    file_path = File.dirname(__FILE__) + "../../config/users/#{file_name}"
    file = File.expand_path(file_path)
    File.read(file)
  end

  # @return [String]
  def self.get_token(user)
    url = URI("#{Capybara.app_host}accrd-ad-api/api/auth/encode")
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request['cache-control'] = 'no-cache'
    request.body = get_body user
    parsed = JSON.parse(http.request(request).read_body) # returns a hash
    parsed['token']
  end
end
