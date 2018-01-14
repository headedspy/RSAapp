RSpec.configure do |config|
	config.use_transactional_fixtures = false
end

key1 = String.new
key2 = String.new
key3 = String.new
testMsg1 = "test_message"
testMsg2 = "t e ./ -="
testMsg3 = ""
msg1 = String.new
msg2 = String.new
msg3 = String.new

RSpec.describe RsasController do
	it "creates new tesst key" do
		post :add_new_key
		key1 = response.body
		post :add_new_key
		key2 = response.body
		post :add_new_key
		key3 = response.body
	end
end

RSpec.describe CryptController do

	it "encrypts" do
		post :encryption, :params => {:message => testMsg1, :id => key1}
		msgid1 = response.body
		msg1 = Encrypted.find(msgid1).send(:msg)
		post :encryption, :params => {:message => testMsg2, :id => key2}
		msgid2 = response.body
		msg2 = Encrypted.find(msgid2).send(:msg)
		post :encryption, :params => {:message => testMsg3, :id => key3}
		msgid3 = response.body
		msg3 = Encrypted.find(msgid3).send(:msg)
	end
end


RSpec.describe DecryptController do
	it "decrypts" do
		old_count = Decrypted.count
		post :decryption, :params => {:message => msg1, :id => key1}
		expect(response.body).to eq testMsg1
		post :decryption, :params => {:message => msg2, :id => key2}
		expect(response.body).to eq testMsg2
		post :decryption, :params => {:message => msg3, :id => key3}
		expect(response.body).to eq testMsg3
		expect(Decrypted.count).to eq old_count+3
	end
	Key.destroy_all
	Encrypted.destroy_all
	Decrypted.destroy_all
end
