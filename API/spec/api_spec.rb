require 'api_base'
require_relative "../lib/json_comparison"

include JsonComparison

describe ApiBase do
	before(:each) do
	    @url_target = "https://reqres.in/api/users/"
		@request_method = "Get"
  	end

	it 'Test API with two JSON data for single loop' do
		# test api with random user id as parameter in endpoint. For the exist user data only 1-12
		result_json_1 = ApiBase.send_api(@url_target, @request_method, rand(1...12).to_s)
		result_json_2 = ApiBase.send_api(@url_target, @request_method, rand(1...12).to_s)

		if ApiBase.validate_id(result_json_1['data']['id'],result_json_2['data']['id'])
	 		expect(compare_json(result_json_1,result_json_2)).to be true
	 	else
	 		expect(compare_json(result_json_1,result_json_2)).to be false
	 	end

	 	p 'success run the first test scenario'
	end

	it "Test API with two JSON data for #{ENV['LOOP']} loop" do
		# test api with random user id as parameter in endpoint. For the exist user data only 1-12 
	 	ENV['LOOP'].to_i.times do
			result_json_1 = ApiBase.send_api(@url_target, @request_method, rand(1...12).to_s)
			result_json_2 = ApiBase.send_api(@url_target, @request_method, rand(1...12).to_s)

			if ApiBase.validate_id(result_json_1['data']['id'],result_json_2['data']['id'])
		 		expect(compare_json(result_json_1,result_json_2)).to be true
		 	else
		 		expect(compare_json(result_json_1,result_json_2)).to be false
		 	end

		 	p "Compare request user ID #{result_json_1['data']['id']} and #{result_json_2['data']['id']}"
		end

		p 'success run the second test scenario'
	end

	it 'Test API with empty JSON data' do
		result_json_1 = []
		result_json_2 = []
		expect { compare_json(result_json_1,result_json_2) }.to raise_error(TypeError)

		p 'success run the third test scenario'
	end

	it 'Test API with nil JSON data' do
		result_json_1 = ""
		result_json_2 = ""
		expect { compare_json(result_json_1,result_json_2) }.to raise_error(TypeError)

		p 'success run the fourth test scenario'
	end
end