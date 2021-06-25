require 'json'
require 'byebug'
require 'rspec/expectations'
require 'resolv-replace'
require 'open-uri'
require 'net/http'
require 'net/https'
require 'uri'
require 'dotenv'

Dotenv.load

class ApiBase
     def self.send_api(base_url, method, endpoint)
	    url = URI(base_url.to_s + endpoint)

	   	case method
	   	when 'Get'
	    	request = Net::HTTP::Get.new(url)
	    else
	    	request = Net::HTTP::Post.new(url)
	    end

	    http = Net::HTTP.new(url.host, url.port)
	    http.open_timeout = 60
	    http.use_ssl = (url.scheme == 'https')
	    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	    retries = 1
	    begin
	      response = http.request(request)
	    rescue Exception => e
	      p e.message
	      retry if (retries += 1) < 5
	      raise e.message if retries == 5
	    end

	    response.body = JSON.parse(response.read_body)  
	 end

	 def self.validate_id(data1, data2)
	 	return false unless data1 == data2
	 	true
	 end
end