class ReportsController < ApplicationController
	before_action :load_research

  def new
  	@report = Report.new
  	@questions = @research.questions
  	@dimensions = @research.dimensions
  	@demographic_variables = @research.demographic_variables
  end

  def create
 		@report = Report.new(permited_params(:report))

  end

  private

  def load_research
  	@research = Research.where(id:params[:id]).includes(:demographic_variables).first
  end

end
