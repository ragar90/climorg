class Report
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :research_id, :dimension_id, :question_id, :demographic_variable_ids, :query_value,
                :show_dimension, :show_question, :show_demographic
end