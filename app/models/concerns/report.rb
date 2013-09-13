module Report
  extend ActiveSupport::Concern
  
  def report(demographic_variable_id,demographic_query_value)
    demographic_variable_id ||=  self.demographic_variable_ids.first
    select_fields = "results.research_id as research_id,results.id as result_id,results.correlative as result_correlative,answers.question_id as question_id,questions.description as question_description,answers.id as answer_id,answers.value as answer_value,questions.ordinal as question_ordinal,questions.dimension_id as dimension_id,dimensions.name as dimension_name,demographic_values.value as demographic_value,demographic_values.demographic_variable_id as demographic_variable_id,demographic_variables.name as demographic_variable_name"
    unless demographic_query_value
      results.joins(answers: {question: :dimension}, demographic_values: :demographic_variable).select(select_fields).where("demographic_variables.id = ?",demographic_variable_id)
    else
      params = demographic_query_value.to_qprm
      results.joins(answers: {question: :dimension}, demographic_values: :demographic_variable).select(select_fields).where("demographic_variables.id = ? ",demographic_variable_id).where(params)
    end
    
  end
  
  def total_perception(options={})
    unless options[:demographic_query_value]
      @total_perception ||= likeable_results(self.report(options[:demographic_variable_id],options[:demographic_query_value]).group("answers.value").select("count(answers.value) as total_likeable, answers.value"))
    else
      results = self.report(options[:demographic_variable_id],options[:demographic_query_value]).group("answers.value").select("count(answers.value) as total_likeable, answers.value")
      likeable_results(results)
    end
    
  end
  
  def filter_by_questions(options = {})
    _questions = questions.group_by{|d| d.id}
    unless options[:dimension_id]
      _results = report(options[:demographic_variable_id],options[:demographic_query_value]).group("questions.id, answers.value").select("questions.id as question_id,answers.value as value, count(answers.value) as total_likeable, results.id as result_id").order("questions.ordinal, answers.value").group_by{|result| result.question_id}
    else
    _results = report(options[:demographic_variable_id],options[:demographic_query_value]).where("questions.dimension_id in (?)",options[:dimension_id]).group("questions.id, answers.value").select("questions.id as question_id,answers.value as value, count(answers.value) as total_likeable, results.id as result_id").order("questions.ordinal, answers.value").group_by{|result| result.question_id}   
    end
    _results.each_key do |key|
      _results[key] = {:question=>_questions[key].first,:results=>likeable_results(_results[key])}
    end
    return _results
  end
  
  def filter_by_dimensions(options = {})
    _dimensions = dimensions.group_by{|d| d.id}
    _results = report(options[:demographic_variable_id],options[:demographic_query_value]).group("questions.dimension_id, answers.value").select("questions.dimension_id,answers.value as value, count(answers.value) as total_likeable, results.id").order("questions.dimension_id, answers.value").group_by{|result| result.dimension_id}
    _results.each_key do |key|
      _results[key] = {:dimension=>_dimensions[key].first,:results=>likeable_results(_results[key])}
    end
    return _results
  end
  
  private
  
  def likeable_results(ungroup_results)
    data = {:likeable=>0,:unlikable=>0, :indiferent=>0}
    ungroup_results.each do |result|
      if result.value > 0 and result.answer_value < 3
         data[:unlikable]+= result.total_likeable
      elsif result.value >= 3 and result.answer_value <= 4
        data[:likeable]+= result.total_likeable
      else
        data[:indiferent]+= result.total_likeable
      end 
    end
    data
  end
end