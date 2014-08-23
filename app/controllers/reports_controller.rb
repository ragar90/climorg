class ReportsController < ApplicationController
  skip_before_filter :clean_report_sessions
	before_action :load_research
  before_action :format_params, only: [:create]

  def new
  	@report = Report.new
    @report.query = DemographicQueryValue.new
  	@questions = @research.questions.order(:ordinal)
  	@dimensions = @research.dimensions.active
  	@demographic_variables = @research.demographic_variables.active
  	@variable_types = {}
  	@demographic_variables.map{|v| [v.id,v.accepted_value,v.queryable_values]}.each do |var|
  		@variable_types[var.first.to_s.to_sym] = [var.second,var.last]
  	end
  end

  def create
 		@report = Report.new(permited_params(:report))
    @title = @report.set_title(params)
    @questions = @research.questions.order(:ordinal)
    @dimensions = @research.dimensions.active
    @demographic_variables = @research.demographic_variables.active
    @variable_types = {}
    @demographic_variables.map{|v| [v.id,v.accepted_value,v.queryable_values]}.each do |var|
      @variable_types[var.first.to_s.to_sym] = [var.second,var.last]
    end
    method_values = @report.report_method
    @data = @research.send(method_values.first,method_values.last) 
    @report_type
    if @data[:chart] == :pie
      @report_type = :pie
      @report_data = @data[:results]
      @report_params = {window_params:{object: @research, data_method: @data[:results], window_title: @title, render_with_link: false, chart_type: :pie,chart_height: 600,report_type: :custom}, chart_params:{title: @title}}
    elsif @data[:results].values.first[:results][:likeable] != nil
      @report_type = :column
      @chart_title = @report.show_questions ? "Preguntas" : @report.query.condition_value_label.titleize      
      @report_data = [[@chart_title, "Satisfactorio"]] + @data[:results].to_barchart_data.sort{|br1, br2| br1.last<=>br2.last }
      @report_params = {window_params:{object:@research,data_method: @report_data, chart_type: :column, report_type: :custom, window_title: @title, render_with_link: false,chart_height: 600}, chart_params:{title: @title, hAxis: {title: @chart_title, gridlines: { count: @report_data.last.last+5 }}}}
    else
      @report_type = :multisiries_column
      serires_names = @data[:results].values.map{|h| h.values.first}
      serires_data = @data[:results].values.map{|h| h.values.last.to_barchart_data}.transpose
      columns = []
      serires_data.each do |a|
        b = []
        a.each do |a2|
          b[0] = a2.first unless b[0]
          b << a2.last
        end
        columns << b
      end
      columns.sort!{|br1, br2| (br1.second > br1.last ? br1.second : br1.last)<=>(br2.second > br2.last ? br2.second : br2.last)}
      @chart_title = @report.show_questions ? "Preguntas" : @report.query.condition_value_label.titleize
      @report_data = [[@chart_title] + serires_names] + columns
      @report_params = {window_params:{object:@research,data_method: @report_data, chart_type: :column, report_type: :custom, window_title: @title, render_with_link: false,chart_height: 600}, chart_params:{title: @title, hAxis: {title: @chart_title, gridlines: { count: @report_data.last.last+5 }}}}
    end
    session[:report] = {data:@report_data, chart:@report_type, title: @title} 
    render action: "new"
  end

  def report
    @research = Research.where(id: params[:id]).first
    @report_type = params[:report_type]
    if session[:report]
      @report_data = session[:report][:data]
      @chart_type = session[:report][:chart]
      @title = session[:report][:title]
    end
    case @report_type
      when "global"
        @data = @research.total_perception[:results]
      when "global_dimensions"
        @data = @research.filter_by_dimensions[:results]
      when "custom"
    end
  end

  private

  def load_research
  	@research = current_organization.researches.where(id:params[:id]).includes(:demographic_variables).first
  end

  def format_params
    permited_params(:report)[:dimension_ids] = permited_params(:report)[:dimension_ids].split(",")
    permited_params(:report)[:demographic_variable_ids] = permited_params(:report)[:demographic_variable_ids].split(",")
    permited_params(:report)[:show_questions] = permited_params(:report)[:show_questions] == "1"
  end

end
