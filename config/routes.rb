Rails.application.routes.draw do
  
  mount ActionCable.server => '/sip_socket'
  
  resources :faqs, :path => "faq" do
    resources :comments
    member do
      post :up
      post :down
    end
  end

  constraints Clearance::Constraints::SignedIn.new do
    # root as: :user_root, :to => 'dash#index'
  end

  resources :passwords,
    controller: 'passwords',
    only: [:create, :new]

  resource :session,
    controller: 'sessions',
    only: [:create]

  resources :users,
    controller: 'users',
    only: Clearance.configuration.user_actions do
      resource :password,
        controller: 'passwords',
        only: [:create, :edit, :update]
    end
    
  get '/disclaimer' => 'main#disclaimer'

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'users#new', as: 'sign_up'

  root "main#index"
end
