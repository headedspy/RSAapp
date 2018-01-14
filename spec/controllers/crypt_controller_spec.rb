RSpec.configure do |config|
	config.use_transactional_fixtures = false
end

RSpec.describe RsasController do
	it "creates new test key" do
		post :add_new_key
		@@key = response.body
	end
end


RSpec.describe CryptController do
	msg = "testmsg"

	it "adds encrypted" do
		old_val = Encrypted.count
		post :encryption, :params => {:message => msg, :id => @@key}
		@@msgid = response.body
		expect(Encrypted.count).to eql old_val+1
	end

	it "returns json" do
		get :extract_encrypted, :params => {:msg_id => @@msgid, :id => 1}
		expect(response.content_type).to eq("application/json")
	end
	Encrypted.destroy_all
	Key.destroy_all
end
