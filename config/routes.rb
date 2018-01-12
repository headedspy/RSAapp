Rails.application.routes.draw do
  resources :decrypteds
  resources :encrypteds
  resources :keys
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	get '/del' => 'rsas#del'

	get '/rsas/:id' => 'rsas#extract'

	post '/rsas' => 'rsas#add_new_key'

	post '/rsas/:id/encrypt_messages' => 'crypt#encryption'

	get '/rsas/:id/encrypt_messages/:msg_id' => 'crypt#extract_encrypted'

	post '/rsas/:id/decrypt_messages' => 'decrypt#decryption'
end
