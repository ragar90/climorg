class ReportsController < ApplicationController
	before_action :load_research
  before_action :format_params, only: [:create]

  def new
  	@report = Report.new
    @report.query = DemographicQueryValue.new
  	@questions = @research.questions.order(:ordinal)
  	@dimensions = @research.dimensions
  	@demographic_variables = @research.demographic_variables
  	@variable_types = {}
  	@demographic_variables.map{|v| [v.id,v.accepted_value,v.queryable_values]}.each do |var|
  		@variable_types[var.first.to_s.to_sym] = [var.second,var.last]
  	end
  end

  def create
 		@report = Report.new(permited_params(:report))
    @questions = @research.questions
    @dimensions = @research.dimensions
    @demographic_variables = @research.demographic_variables
    @variable_types = {}
    @demographic_variables.map{|v| [v.id,v.accepted_value,v.queryable_values]}.each do |var|
      @variable_types[var.first.to_s.to_sym] = [var.second,var.last]
    end
    method_values = @report.report_method
    @data = @research.send(method_values.first,method_values.last)
    render action: "new"
  end

  private

  def load_research
  	@research = Research.where(id:params[:id]).includes(:demographic_variables).first
  end

  def format_params
    permited_params(:report)[:dimension_ids] = permited_params(:report)[:dimension_ids].split(",")
    permited_params(:report)[:question_ids] = permited_params(:report)[:question_ids].split(",")
    permited_params(:report)[:demographic_variable_ids] = permited_params(:report)[:demographic_variable_ids].split(",")
  end

end
