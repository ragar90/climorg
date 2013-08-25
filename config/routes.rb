ClimaOrg::Application.routes.draw do

  root :to => 'home#index'
  get "home/index"
  resources :researches do
    resources :reports
    resources :results, :except=>[:show]
    member do
      put 'confirm'
      get "survey"
    end
  end
  resources :questions
  resources :dimensions
  resources :demographic_variables
end
