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
      get "report/global" => "researches#report", defaults:{report_type: "global"}
      get "report/global_dimensions" => "researches#report", defaults:{report_type: "global_dimensions"}
      get "report/dimension_demographic" => "researches#report", defaults:{report_type: "dimension_demographic"}
      get "report/dimension_questions" => "researches#report", defaults:{report_type: "dimension_questions"}
      get "report/dimension_questions_demographic" => "researches#report", defaults:{report_type: "dimension_questions_demographic"}
      get "report/global_questions" => "researches#report", defaults:{report_type: "global_questions"}
      get "report/questions_demographic" => "researches#report", defaults:{report_type: "questions_demographic"}
    end
  end
  resources :questions
  resources :dimensions
  resources :demographic_variables
end
