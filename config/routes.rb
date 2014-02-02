ClimaOrg::Application.routes.draw do
  root :to => 'researches#index'
  get "home/index"
  resources :researches do
    resources :applications, controller: :research_application, except: [:show] do
      resources :results, :except=>[:show]
    end
    member do
      put 'confirm'
      get "survey"
      resources :reports, :only=>[:new,:create]
      get "report/global" => "researches#report", defaults:{report_type: "global"}
      get "report/global_dimensions" => "researches#report", defaults:{report_type: "global_dimensions"}
    end
  end
  resources :questions
  resources :dimensions
  resources :demographic_variables
end
