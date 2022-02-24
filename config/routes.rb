Rails.application.routes.draw do
  resources :students, only: [:update, :create]
  post '/create_with_csv', to: 'students#create_with_csv'
  get '/students/:id/uffmail_options', to: 'students#generate_uffmail_options', as: :uffmail_options
  put '/student/:id/set_uffmail', to: 'students#set_uffmail'
  get '/csv_import', to: 'imports#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
