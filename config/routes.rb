Rails.application.routes.draw do
  resources :shifts do
    collection do
      post :filter_data
    end
  end
  resources :organisations do
  	member do
  		get "join_in_or_out",action: :join_in_or_out,as: :join_in_or_out 
  	end
  end
  devise_for :users
  devise_scope :user do
	  root to: "devise/sessions#new"
	  get '/users/sign_out' => 'devise/sessions#destroy'
	  get '/users/sign_up' => 'devise/sessions#new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
