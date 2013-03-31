class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_layout

  def load_layout
  	@layout = (params[:layout].nil? or params[:layout]==true) ? true : false
  end
end
