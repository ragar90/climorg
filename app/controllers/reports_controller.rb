class ReportsController < ApplicationController
	before_action :load_research

  def new
  	@report = Report.new
  	@questions = @research.questions
  	@dimensions = @research.dimensions
  	@demographic_variables = @research.demographic_variables
  	@variable_types = {}
  	@demographic_variables.map{|v| [v.id,v.accepted_value,v.queryable_values]}.each do |var|
  		@variable_types[var.first.to_s.to_sym] = [var.second,var.last]
  	end
  end

  def create
 		@report = Report.new(permited_params(:report))

  end

  private

  def load_research
  	@research = Research.where(id:params[:id]).includes(:demographic_variables).first
  end

end
