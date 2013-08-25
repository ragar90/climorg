class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_layout

  def load_layout
  	@layout = (params[:layout].nil? or params[:layout]==true) ? true : false
  end
  
  def permited_params(resource)
    klass = resource.to_s.classify.constantize
    params.require(resource.to_sym).permit!
    #params.require(resource.to_sym).permit(klass.whitelist_attributes)
  end
end
