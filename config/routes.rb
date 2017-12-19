Rails.application.routes.draw do
  resources :keys
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get '/rsas' => 'rsas#add_new_key'

	get '/del' => 'rsas#del'

	get '/rsas/:id' => 'rsas#extract'

	post '/rsas' => 'rsas#add_custom_key'
end