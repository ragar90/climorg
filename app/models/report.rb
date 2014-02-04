class Report
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :research_id, :dimension_ids, :demographic_variable_ids, :query,
                :show_questions

  def initialize(params = {})
    if params.length == 0
      self.dimension_ids = []
      self.demographic_variable_ids = []
    else
    	params.each do |attribute, value|
        if attribute.to_s == "query" and params[:query].values.select{|val| !val.blank?}.length != 0
          self.query = DemographicQueryValue.new(params[:query])
        elsif attribute != "query"
          self.send("#{attribute}=",value)  
        end
    	end
    end
  end

  def report_method
    if self.show_demographic == "1" and self.show_dimension == "1" and self.show_question == "1"
      [:filer_by_variables,{filter_by: :dimensions_and_questions,query: {question_id: self.question_ids,dimension_id:self.dimension_ids.first, variable_id:self.demographic_variable_ids.first, query_value: self.query }}]
    elsif self.show_question == "1" and self.show_dimension == "1"
      [:filter_by_questions, {question_id: self.question_ids,dimension_id:self.dimension_ids.first}]
    elsif self.show_question == "1" and self.show_demographic == "1"
      [:filer_by_variables,{filter_by: :questions,query: {question_id: self.question_ids,variable_id:self.demographic_variable_ids.first, query_value: self.query }}]
    elsif self.show_dimension == "1" and self.show_demographic == "1"
      [:filer_by_variables,{filter_by: :dimensions,query: {dimension_id:self.dimension_ids.first, variable_id:self.demographic_variable_ids.first, query_value: self.query }}]
    elsif self.show_dimension == "1"
      [:filter_by_dimensions,{dimension_id:self.dimension_ids.first}]
    elsif self.show_question == "1"
      [:filter_by_questions, {question_id: self.question_ids}]
    elsif self.show_demographic == "1"
      [:filer_by_variables,{query: {variable_id:self.demographic_variable_ids.first, query_value: self.query }}]
    end
  end
end