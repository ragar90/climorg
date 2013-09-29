class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :load_layout
  before_action :selected_option

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
end
