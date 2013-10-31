ClimaOrg::Application.routes.draw do
  root :to => 'researches#index'
  get "home/index"
  resources :researches do
    resources :reports
    resources :applications, controller: :research_application, except: [:show] do
      resources :results, :except=>[:show]
    end
    member do
      put 'confirm'
      get "survey"
    end
  end
  resources :questions
  resources :dimensions
  resources :demographic_variables
end
