require 'prime'
require 'json'

class RsasController < ApplicationController
protect_from_forgery unless: -> {request.format.json? }
protect_from_forgery with: :null_session
	

	def index
	end

	def haveCommonDividors(arg1, arg2)
		(2..arg1).each do |num|
			return true if arg1 % num == 0 and arg2 % num == 0
		end
		return false
	end

	def generatePrime
		Prime.take(rand(2..2**7)).reverse[0]
	end

#-------------------------------------------------------------------------------

	def new_key
		p = generatePrime
		q = generatePrime

		while q==p
			q = generatePrime
		end

		n = p*q

		fn = (p-1)*(q-1)
		e = rand(1..fn)

		while haveCommonDividors(e, fn) == true
			e = rand(1..fn)
		end

		for d in 1..fn
			if((d*e)-1)%fn == 0
				break
			end
		end

		values = Array.new
		values << n
		values << e
		values << d

		values
	end

	@@ids = (1000..9999).to_a.shuffle

	def getId
		@@ids.pop
	end

	def add_new_key

		if params.has_key?(:n) and params.has_key?(:e) and params.has_key?(:d)
			n = params[:n]
			e = params[:e]
			d = params[:d]
		else
			arr = new_key
			n = arr[0]
			e = arr[1]
			d = arr[2]
		end

		a = Key.create(:n=>n, :e=>e, :d=>d, :id=>getId())
		b = a.save
		render plain: a.id
	end

	def del
		Key.destroy_all
		ActiveRecord::Base.connection.execute('TRUNCATE Keys')

		render plain: "Del"
	end

	def extract
		num = params[:id]
		arr = Array.new
		arr << Key.find(num.to_i).send(:n)
		arr << Key.find(num.to_i).send(:e)
		arr << Key.find(num.to_i).send(:d)
		res = {"n" => arr[0].to_i, "e" => arr[1], "d" => arr[2]}
		render json: res
	end

end
