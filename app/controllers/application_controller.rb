class ApplicationController < ActionController::Base
  #http_basic_authenticate_with :name => "admin", :password => "climorgadmin"
  protect_from_forgery with: :exception
  before_filter :load_layout
  before_action :selected_option
  before_filter :clean_report_sessions
  before_action :authenticate
  before_action :load_current_organization

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

  def load_current_organization
    @organizations = current_user.organizations
    if params[:selected_org_id].present?
      @current_organization = @organizations.where(id:params[:selected_org_id]).first
      session[:selected_org_id] = params[:selected_org_id]
    elsif session[:selected_org_id].present?
      @current_organization = @organizations.where(id:session[:selected_org_id]).first
    else
      @current_organization = @organizations.first
    end
  end

  def current_organization
    @current_organization
  end
  helper_method :current_organization
  
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
