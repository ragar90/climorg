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
    data = self.report(options[:demographic_variable_id],options[:demographic_query_value]).group("answer_value").select("count(answer_value) as total_likeable, answer_value")
    likeable_results(data)
  end
  
  def filter_by_questions(options = {})
    _questions = questions.group_by{|d| d.id}
    data = nil
    unless options[:dimension_id]
      data = report(options[:demographic_variable_id],options[:demographic_query_value]).group("question_id,answer_value,result_id,question_ordinal").select("question_id,answer_value, count(answer_value) as total_likeable, result_id").order("question_ordinal, answer_value")
    else
      data = report(options[:demographic_variable_id],options[:demographic_query_value]).where("dimension_id in (?)",options[:dimension_id]).group("question_id, answer_value,question_ordinal, result_id").select("question_id,answer_value, count(answer_value) as total_likeable, result_id").order("question_ordinal, answer_value")  
    end
    _results = data.group_by{|result| result.question_id}
    _results.each_key do |key|
      _results[key] = {:question=>_questions[key].first,:results=>likeable_results(_results[key])}
    end
    return _results
  end
  
  def filter_by_dimensions(options = {})
    _dimensions = dimensions.group_by{|d| d.id}
    _results = report(options[:demographic_variable_id],options[:demographic_query_value]).group("dimension_id, answer_value, result_id").select("dimension_id,answer_value, count(answer_value) as total_likeable, result_id").order("dimension_id, answer_value").group_by{|result| result.dimension_id}
    _results.each_key do |key|
      _results[key] = {:dimension=>_dimensions[key].first,:results=>likeable_results(_results[key])}
    end
    return _results
  end
  
  def filer_by_variables(options = {})
    options[:filter_by] ||= :global
    options[:filter_by] = options[:filter_by].to_sym
    results = []
    if options[:query]
      result =  case options[:filter_by]
                  when :questions
                    filter_by_questions(demographic_variable_id: options[:query][:variable_id], demographic_query_value: options[:query][:value])
                  when :dimensions
                    filter_by_dimensions(demographic_variable_id: options[:query][:variable_id], demographic_query_value: options[:query][:value])
                  else
                    total_perception(demographic_variable_id: options[:query][:variable_id], demographic_query_value: options[:query][:value])
                end
      results << result
      results << options[:query][:value].condition_value_label
    else
      variables = self.variables_values
      variables.each do |variable|
        variable[:queryable_values].each do |queryable_value|
          result =  case options[:filter_by]
                      when :questions
                        filter_by_questions(demographic_variable_id: variable[:id], demographic_query_value: queryable_value)
                      when :dimensions
                        filter_by_dimensions(demographic_variable_id: variable[:id], demographic_query_value: queryable_value)
                      else
                        total_perception(demographic_variable_id: variable[:id], demographic_query_value: queryable_value)
                    end
          results << result
        end
      end
    end
    return results
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