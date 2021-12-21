require 'net/http'

class MarvinHTTPApi
  
  def initialize
    @sync_user = ENV["SYNC_USER"]
    @sync_password = ENV["SYNC_PASSWORD"]
    @sync_server = ENV["SYNC_SERVER"]
    @sync_database = ENV["SYNC_DATABASE"]
  end
  
  def post(resource, hash_json)
    url = build_url(resource)
    uri = URI.parse(url)
    req = Net::HTTP::Post.new(uri.to_s)
    req.body = hash_json
    req.basic_auth @sync_user, @sync_password
    req['Content-Type'] = 'application/json'
    
    response = https(uri).request(req)
    response.body
  end

  def get(resource)
    url = build_url(resource)
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.to_s)
    req.basic_auth @sync_user, @sync_password
    req['Content-Type'] = 'application/json'

    response = https(uri).request(req)
    response.body
  end
  
  def put(resource, hash_json)
    url = build_url(resource) 
    uri = URI.parse(url)
    req = Net::HTTP::Put.new(uri.to_s)
    req.body = hash_json
    req.basic_auth @sync_user, @sync_password
    req['Content-Type'] = 'application/json'
    
    response = https(uri).request(req)
    response.body
  end
  
  private
  def build_url(resource)
    "https://#{@sync_server}/#{@sync_database}/#{resource}"
  end
  
  def https(uri)
    Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end
end
