class ResultReport < ActiveRecord::Base
  belongs_to :research
  belongs_to :result
  belongs_to :question
  belongs_to :answer
  belongs_to :dimension
  belongs_to :demographic_value
  belongs_to :demographic_variable
  scope :general_results, ->(research_id)  { where(:research_id=>research_id) }
  scope :general_data, ->(research_id) { general_results(research_id).group("answer_value").select("count(answer_value) as total_likeable, answer_value, demographic_variable_id") }
  scope :by_dimension, ->(research_id, dimensions_ids,varaible_id) { general_results(research_id).where(:dimension_id=>dimensions_ids).group("dimension_id, answer_value").select("dimension_id,answer_value, count(answer_value) as total_likeable").order("dimension_id, answer_value") }
  scope :by_question, ->(research_id, questions_ids,varaible_id) { general_results(research_id).where(:question_id=>questions_ids).group("question_id, answer_value").select("question_id,answer_value, count(answer_value) as total_likeable").order("question_id, answer_value") }
  
  def self.perception_by(research,variable_type = :all, conditions={})
    unless variable_type == :all
      self.send("total_perception_by_#{variable_type}", research)
    else
      total_perception(research)
    end
  end
  
  def self.total_perception(research)
    demographic_variables = research.demographic_variable_ids.length
    likeable_results(general_data(research.id),demographic_variables)
  end
  
  def self.total_perception_by_dimension(research)
    dimensions = research.dimensions.group_by{|d| d.id}
    demographic_variable_id = research.demographic_variable_ids.first
    demographic_variables = research.demographic_variable_ids.length
    results = by_dimension(research.id, dimensions.keys).group_by{|result| result.dimension_id}
    results.each_key do |key|
        results[key] = {:dimension=>dimensions[key].first,:results=>likeable_results(results[key],demographic_variables)}
    end
  end
  
  def self.total_perception_by_question(research)
    questions = research.questions.group_by{|q| q.id}
    demographic_variables = research.demographic_variable_ids.length
    results = by_question(research.id, questions.keys).group_by{|result| result.question_id}
     results.each_key do |key|
        results[key] = {:question=>questions[key].first,:results=>likeable_results(results[key],demographic_variables)}
     end
  end
  
  def self.likeable_results(ungroup_results, total_demographic_variables=1)
    data = {:likeable=>0,:unlikable=>0, :indiferent=>0}
    ungroup_results.each do |result|
      if result.answer_value > 0 and result.answer_value < 3
         data[:likeable]+= result.total_likeable
      elsif result.answer_value >= 3 and result.answer_value <= 4
        data[:unlikable]+= result.total_likeable
      else
        data[:indiferent]+= result.total_likeable
      end 
    end
    #data[:likeable]/=total_demographic_variables
    #data[:unlikable]/=total_demographic_variables
    #data[:indiferent]/=total_demographic_variables
    return data
  end
  
end