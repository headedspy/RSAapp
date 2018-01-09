class CryptController < ApplicationController
protect_from_forgery unless: -> {request.format.json?}
	@@ids = (1000..9999).to_a.shuffle

	def getId
		@@ids.pop
	end

	def encryption
		msg = params[:message]
		id = params[:id]
		new = String.new

		e = Key.find(id.to_i).send(:e)
		n = Key.find(id.to_i).send(:n)

		msg.each_char do |ch|
			o = ((ch.ord)**e)%n
			new << o.to_s
			if ch != msg[-1]
				new << ","
			end
		end

		a = Encrypted.create(:msg => new, :id=>getId())

		render plain: a.id
	end


	def extract_encrypted
		id = params[:msg_id]
		msg = Encrypted.find(id).send(:msg)
		res = {"message" => msg}
		render json: res
	end
end
