RSpec.describe RsasController do
	it "adds custom key" do
		old_val = Key.count
		post :add_new_key, params: {n:1, e:2, d:3}
		expect(Key.count).to eql old_val+1
	end

	it "adds generated key" do
		old_val = Key.count
		post :add_new_key
		expect(Key.count).to eql old_val+1
	end

	it "returns correct values" do	
		res = post :add_new_key, params: {n:15, e:82, d:302}
		
		expected_outcome = {
			:n => 15,
			:e => 82,
			:d => 302
		}.to_json

		get :extract , params: {id:res.body}
		expect(response.content_type).to eq("application/json")
		expect(response.body).to eq expected_outcome
	end
end
