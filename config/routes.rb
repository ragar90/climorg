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
      get "report/global" => "reports#report", defaults:{report_type: "global"}
      get "report/global_dimensions" => "reports#report", defaults:{report_type: "global_dimensions"}
      get "report/custom" => "reports#report", defaults:{report_type: "custom"}
    end
  end
  resources :questions
  resources :dimensions
  resources :demographic_variables
end
