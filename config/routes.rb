Easyblog::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments do
      member do
        get :vote_up
        get :vote_down
        get :mark_as_not_abusive
      end
    end
    member do
      post :mark_archived
    end
  end
end
