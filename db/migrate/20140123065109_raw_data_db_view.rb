class RawDataDbView < ActiveRecord::Migration
  def up
  	execute "create view raw_data as SELECT results.research_id as research_id,results.id as result_id,results.correlative as result_correlative,answers.question_id as question_id,questions.description as question_description,answers.id as answer_id,answers.value as answer_value,questions.ordinal as question_ordinal,questions.dimension_id as dimension_id,dimensions.name as dimension_name,demographic_values.value as demographic_value,demographic_values.demographic_variable_id as demographic_variable_id,demographic_variables.name as demographic_variable_name FROM results INNER JOIN answers ON answers.result_id = results.id INNER JOIN questions ON questions.id = answers.question_id INNER JOIN dimensions ON dimensions.id = questions.dimension_id INNER JOIN demographic_values ON demographic_values.result_id = results.id INNER JOIN demographic_variables ON demographic_variables.id = demographic_values.demographic_variable_id;"
  end
  def down
  	execute "drop view raw_data"
  end
end


