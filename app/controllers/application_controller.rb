class ApplicationController < ActionController::Base
  #http_basic_authenticate_with :name => "admin", :password => "climorgadmin"
  protect_from_forgery with: :exception
  before_filter :load_layout
  before_action :selected_option
  before_filter :clean_report_sessions
  before_action :authenticate 

  def load_layout
  	@layout = (params[:layout].nil? or params[:layout]==true) ? true : false
  end
  
  def permited_params(resource)
    klass = resource.to_s.classify.constantize
    params.require(resource.to_sym).permit!
    #params.require(resource.to_sym).permit(klass.whitelist_attributes)
  end

  def selected_option
     @selected_option = case params[:controller]
                          when "demographic_variables"
                            "demo-vars-option"
                          when "dimensions"
                            "dimension-option"
                          when "questions"
                            "questions-option"
                          when "settings"
                            "settings-option"
                          else
                            "home-option"
                        end
  end
  
  private

  def authenticate
    if self.class != HomeController
      authenticate_user!
    end
  end

  def clean_report_sessions
    session[:report] = nil
  end

  def breakpoint
    raise RuntimeError
  end
end
