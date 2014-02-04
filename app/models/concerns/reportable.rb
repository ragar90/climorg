module Reportable
  extend ActiveSupport::Concern
  
  def report(demographic_variable_id,demographic_query_value)
    demographic_variable_id ||=  self.demographic_variable_ids.first
    unless demographic_query_value
      RawData.where("demographic_variable_id = ? and research_id = ?",demographic_variable_id, self.id)
    else
      params = demographic_query_value.to_qprm
      RawData.where("demographic_variable_id = ? and research_id = ? ",demographic_variable_id,self.id).where(params)
    end
  end
  
  def total_perception(options={})
    data = self.report(options[:variable_id],options[:query_value]).group("answer_value").select("count(answer_value) as total_likeable, answer_value")
    likeable_results(data)
  end

  def filter_by_dimensions(options = {})
    d = dimensions.where(id:options[:dimension_id]).first
    if options[:questions]
      results = {dimension: d, results: filter_by_questions(options[:dimension_id])}
    elsif options[:dimension_id]
      results = report(options[:variable_id],options[:query_value]).where(dimension_id:options[:dimension_id]).group("dimension_id, answer_value, result_id").select("dimension_id,answer_value, count(answer_value) as total_likeable, result_id").order("dimension_id, answer_value")
      results = {:dimension=>d,:results=>likeable_results(results)}
    else
      dimensions = self.dimensions.group_by{|d| d.id}
      results = report(options[:variable_id],options[:query_value]).group("dimension_id, answer_value, result_id").select("dimension_id,answer_value, count(answer_value) as total_likeable, result_id").order("dimension_id, answer_value").group_by{|result| result.dimension_id}
      results.each_key do |key|
        results[key] = {:dimension=>dimensions[key].first,:results=>likeable_results(results[key])}
      end
    end
    return results
  end
  
  def filter_by_questions(options = {})
    unless options[:dimension_id]
      raise ArgumentError, 'You must provide a dimension in order to generate a question report'
    end
    questions = self.questions.group_by{|d| d.id}
    data = report(options[:variable_id],options[:query_value]).where(dimension_id: options[:dimension_id]).group("question_id, answer_value,question_ordinal, result_id").select("question_id,answer_value, count(answer_value) as total_likeable, result_id").order("question_ordinal, answer_value")
    results = data.group_by{|result| result.question_ordinal}
    results.each_key do |key|
      results[key] = {:question=>questions[key].first,:results=>likeable_results(results[key])}
    end
    return results
  end
  
  def filer_by_variables(options = {})
    options[:dimensions] ? filter_by_dimensions(options[:query]) : total_perception(options[:query])
  end
  
  private
  
  def likeable_results(ungroup_results)
    data = {:likeable=>0,:unlikable=>0, :indiferent=>0}
    ungroup_results.each do |result|
      if result.answer_value > 0 and result.answer_value < 3
         data[:unlikable]+= result.total_likeable
      elsif result.answer_value >= 3 and result.answer_value <= 4
        data[:likeable]+= result.total_likeable
      else
        data[:indiferent]+= result.total_likeable
      end 
    end
    data
  end
end