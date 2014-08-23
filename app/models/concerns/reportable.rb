module Reportable
  extend ActiveSupport::Concern
  
  def report(demographic_variable_id,demographic_query_value)
    demographic_variable_id ||=  self.demographic_variable_ids.first
    if demographic_query_value.nil? or demographic_query_value.condition_value.blank?
      RawData.where("demographic_variable_id = ? and research_id = ?",demographic_variable_id, self.id)
    else
      params = demographic_query_value.to_qprm
      RawData.where("demographic_variable_id = ? and research_id = ? ",demographic_variable_id,self.id).where(params)
    end
  end
  
  def total_perception(options={})
    if options[:variable_id] and options[:query_value].condition_value.blank?
      data = self.report(options[:variable_id],options[:query_value]).group("answer_value,demographic_value ").select("count(answer_value) as total_likeable, answer_value,demographic_value")
      var = DemographicVariable.where(id: options[:variable_id]).first
      data = data.group_by{|r| r.demographic_value}
      data.each_key do |key|
        data[key] = {variable: var.label_for_value(key), results: likeable_results(data[key])}
      end
      data = {:dimension=>nil,:results=> data, chart: :bars }
    else
      data = self.report(options[:variable_id],options[:query_value]).group("answer_value").select("count(answer_value) as total_likeable, answer_value")
      {dimension: nil, results: likeable_results(data), chart: :pie}
    end
  end

  def filter_by_dimensions(options = {})
    d = dimensions.active.where(id:options[:dimension_id]).first
    if options[:questions]
      results = {dimension: d, results: filter_by_questions(options), chart: :bars}
    elsif options[:dimension_id]
      results = report(options[:variable_id],options[:query_value]).where(dimension_id:options[:dimension_id]).group("dimension_id, answer_value, result_id, demographic_value").select("dimension_id,answer_value, count(answer_value) as total_likeable, result_id, demographic_value").order("dimension_id, answer_value")
      if options[:variable_id] and options[:query_value].condition_value.blank?
        var = DemographicVariable.where(id: options[:variable_id]).first
        results = results.group_by{|r| r.demographic_value}
        results.each_key do |key|
          results[key] = {variable: var.label_for_value(key), results: likeable_results(results[key])}
        end
        results = {:dimension=>d,:results=> results, chart: :bars }
      else
        results = {:dimension=>d,:results=>likeable_results(results), chart: :pie}
      end
    else
      dimensions = self.dimensions.active.group_by{|d| d.id}
      results = report(options[:variable_id],options[:query_value]).group("dimension_id, answer_value, result_id").select("dimension_id,answer_value, count(answer_value) as total_likeable, result_id").order("dimension_id, answer_value").group_by{|result| result.dimension_id}
      results.each_key do |key|
        results[key] = {:dimension=>dimensions[key].first,:results=>likeable_results(results[key])}
      end
      {dimension: :collection,results: results, chart: :bars}
    end
  end
  
  def filter_by_questions(options = {})
    unless options[:dimension_id]
      raise ArgumentError, 'You must provide a dimension in order to generate a question report'
    end
    questions = self.questions.group_by{|d| d.ordinal}
    data = report(options[:variable_id],options[:query_value]).where(dimension_id: options[:dimension_id]).group("question_id, answer_value,question_ordinal, result_id, demographic_value").select("question_id,answer_value, count(answer_value) as total_likeable, result_id, question_ordinal, demographic_value").order("question_ordinal, answer_value")
    if options[:variable_id] and options[:query_value].condition_value.blank?
      var = DemographicVariable.where(id: options[:variable_id]).first
      data = data.group_by{|r| r.demographic_value}
      data.each_key do |key|
        grouped_by_questions = data[key].group_by{|result| result.question_ordinal}
        grouped_by_questions.each_key do |key|
          grouped_by_questions[key] = {:question=>questions[key].first,:results=>likeable_results(grouped_by_questions[key])}
        end
        data[key] = {variable: var.label_for_value(key), results: grouped_by_questions }
      end
    else
      results = data.group_by{|result| result.question_ordinal}
      results.each_key do |key|
        results[key] = {:question=>questions[key].first,:results=>likeable_results(results[key])}
      end
    end
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