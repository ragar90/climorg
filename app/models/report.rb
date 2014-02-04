class Report
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :research_id, :dimension_ids, :question_ids, :demographic_variable_ids, :query_value,
                :show_dimension, :show_question, :show_demographic

  def initialize(params)
    if params.length == 0
      self.dimension_ids = []
      self.question_ids = []
      self.demographic_variable_ids = []
    else
    	params.each do |attribute, value|
    		self.send("#{attribute}=",value)
    	end
    end
  end

  def report_method
    if self.show_demographic == "1" and self.show_dimension == "1" and self.show_question == "1"
      [:filer_by_variables,{filter_by: :dimensions_and_questions,query: {dimension_id:self.dimension_ids.first, variable_id:self.demographic_variable_ids.first, value: self.query_value }}]
    sss.sss
    elsif self.show_dimension == "1"
      [:filter_by_dimensions,{demographic_variable_id:self.demographic_variable_ids.first, demographic_query_value: self.query_value }]
    elsif self.show_question == "1"
      [:filter_by_questions, {demographic_variable_id:self.demographic_variable_ids.first, demographic_query_value: self.query_value }]
    elsif self.show_demographic == "1"
      [:filer_by_variables,{query: {variable_id:self.demographic_variable_ids.first, value: self.query_value }}]
    elsif self.show_question == "1" and self.show_dimension == "1"
      [:filter_by_questions, {dimension_id:self.dimension_ids.first,demographic_variable_id:self.demographic_variable_ids.first, demographic_query_value: self.query_value }]
    elsif self.show_question == "1" and self.show_demographic == "1"
      [:filer_by_variables,{filter_by: :questions,query: {dimension_id:self.dimension_ids.first, variable_id:self.demographic_variable_ids.first, value: self.query_value }}]
    elsif self.show_dimension == "1" and self.show_demographic == "1"
      [:filer_by_variables,{filter_by: :dimensions,query: {dimension_id:self.dimension_ids.first, variable_id:self.demographic_variable_ids.first, value: self.query_value }}]
    end
  end
end