require 'api_base'
require_relative "../lib/json_compare"

include JsonComparison

describe ApiBase do
	before(:each) do
	    @url_target = "https://reqres.in/api/users/"
		@request_method = "Get"
  	end

	it 'Test API with two JSON data for single request' do
		result_json_1 = ApiBase.send_api(@url_target, @request_method, rand(1...10).to_s)
		result_json_2 = ApiBase.send_api(@url_target, @request_method, rand(1...10).to_s)

		if ApiBase.validate_id(result_json_1['data']['id'],result_json_2['data']['id'])
	 		expect(compare_json(result_json_1,result_json_2)).to be true
	 	else
	 		expect(compare_json(result_json_1,result_json_2)).to be false
	 	end
	end

	it 'Test API for multiple request' do
		result_json_1 = ApiBase.send_api(@url_target, @request_method, rand(1...10).to_s)
		result_json_2 = ApiBase.send_api(@url_target, @request_method, rand(1...10).to_s)

	 	1000.times do
			result_json_1 = ApiBase.send_api(@url_target, @request_method, rand(1...10).to_s)
			result_json_2 = ApiBase.send_api(@url_target, @request_method, rand(1...10).to_s)

			p "Compare request user ID #{result_json_1['data']['id']} and #{result_json_2['data']['id']}"

			if ApiBase.validate_id(result_json_1['data']['id'],result_json_2['data']['id'])
		 		expect(compare_json(result_json_1,result_json_2)).to be true
		 	else
		 		expect(compare_json(result_json_1,result_json_2)).to be false
		 	end
		end
	end

	it 'Test API with empty JSON data' do
		result_json_1 = []
		result_json_2 = []
		expect { compare_json(result_json_1,result_json_2) }.to raise_error(TypeError)
	end

	it 'Test API with nil JSON data' do
		result_json_1 = ""
		result_json_2 = ""
		expect { compare_json(result_json_1,result_json_2) }.to raise_error(TypeError)
	end
end