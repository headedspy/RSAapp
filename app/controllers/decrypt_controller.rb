class DecryptController < ApplicationController
	protect_from_forgery unless: -> {request.format.json?}
	def decryption
		id = params[:id]
		msg = params[:message]

		n = Key.find(id.to_i).send(:n)
		d = Key.find(id.to_i).send(:d)

		new = String.new

		msg.split(',').each do |ch|
			o = ((ch.to_i)**d)%n
			new << o
		end
		render plain: new
	end

end
