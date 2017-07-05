require 'net/http'
require 'uri'
require 'rubygems'
require 'json'


module HTTPHelper


  def self.get_body(user)
    file_name = ''
    case user
      when 'Пользователь 1'
        file_name = 'accrduser0.json'
      when 'Пользователь 2'
        file_name = 'U_M0KVS.json'
      when 'Пользователь 3'
        file_name = 'U_M0KVS_without_client.json'
      when 'Пользователь 4'
        file_name = 'U_M0SJH.json'
      when 'Пользователь 5'
        file_name = 'U_M066X.json'
      else
        puts 'Error'
    end

    p File.read(File.expand_path(File.dirname(__FILE__) + "../../config/users/#{file_name}"))
  end

  # @return [String]
  def self.get_token(user)
    url = URI('http://ufrvpndev/accrd-ad-api/api/auth/encode')

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request['cache-control'] = 'no-cache'
    request.body = get_body  user
    puts request.body

    response = http.request(request)
    parsed = JSON.parse(response.read_body) # returns a hash
    p parsed['token']
  end


end