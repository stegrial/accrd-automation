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
      when 'Пользователь 6'
        file_name = 'u_m0w63_accr.json'
      else
        puts 'Error'
    end

    p File.read(File.expand_path(File.dirname(__FILE__) + "../../config/users/#{file_name}"))
  end

  # @return [String]
  def self.get_token(user)
    url = URI("#{Capybara.app_host}accrd-ad-api/api/auth/encode")

    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request['cache-control'] = 'no-cache'
    request.body = get_body user
    puts request.body

    response = http.request(request)
    parsed = JSON.parse(response.read_body) # returns a hash
    p parsed['token']
  end

  # @return [String]
  # @param [Object] date
  # @param [Object] covering_account
  def self.get_acc_statement(date, covering_account)
    # url = URI('http://vuwsvpn:9080/CS/EQ/WSAccountStatement/WSAccountStatement10')
    # http = Net::HTTP.new(url.host, url.port)
    # request = Net::HTTP::Post.new(url)
    # request['content-type'] = 'text/xml;'
    # request['charset'] = 'UTF-8'
    # request['soapaction'] = '/CS/EQ/WSSettlementCreateDocRUR12#Add'
    #
    # xml = get_statement_body date, covering_account
    # puts xml
    # request.body = xml
    #
    # puts request
    #
    # response = http.request(request)
    # puts response.body
    # puts response.code
   # parsed = JSON.parse(response.read_body) # returns a hash
   # p parsed


    url = URI('http://vuwsvpn:9080/CS/EQ/WSAccountStatement/WSAccountStatement10')

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'text/xml'
    request['charset'] = 'UTF-8'
    request['soapaction'] = '/CS/EQ/WSSettlementCreateDocRUR12#Add'
    request.body = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:wsac=\"http://WSAccountStatement10.EQ.CS.ws.alfabank.ru\">\r\n    <soapenv:Header/>\r\n    <soapenv:Body>\r\n        <wsac:WSAccountStatementGet>\r\n            <inCommonParms>\r\n                <userID>WSFA</userID>\r\n                <externalSystemCode>GRCHVPN</externalSystemCode>\r\n                <externalUserCode>UFA</externalUserCode>\r\n            </inCommonParms>\r\n            <inParms>\r\n                <ean>40901810700000000384</ean>\r\n                <sdt>2017-10-23T00:00:00+00:00</sdt>\r\n                <edt>2017-10-23T00:00:00+00:00</edt>\r\n                <cot>F</cot>\r\n                <ino>0</ino>\r\n                <ovo>N</ovo>\r\n                <tro>N</tro>\r\n            </inParms>\r\n        </wsac:WSAccountStatementGet>\r\n    </soapenv:Body>\r\n</soapenv:Envelope>"

    response = http.request(request)
    puts response.read_body

  end

  def self.get_statement_body(date, covering_account)

    # Change date in xml
    doc = Nokogiri::XML(File.open('config/accountStatement.xml'))
    node = doc.xpath('//inParms//sdt')[0] # use [0] to select the first result
    node.content = date

    node = doc.xpath('//inParms//edt')[0]
    node.content = date

    node = doc.xpath('//inParms//ean')[0]
    node.content = covering_account
    p doc
  end


end