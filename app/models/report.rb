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
      self.show_questions = false
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
    dimension_ids = self.dimension_ids.length > 0 ? self.dimension_ids : nil
    demographic_variable_ids = self.demographic_variable_ids.length > 0 ? self.demographic_variable_ids : nil
    params = {questions: self.show_questions,dimension_id: dimension_ids,variable_id: demographic_variable_ids,query_value: self.query}
    dimension_ids.nil? ? [:total_perception, params] : [:filter_by_dimensions,params]
  end
end