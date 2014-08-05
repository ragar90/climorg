module ReportsHelper
  def filter_field(type,values,selected_type, selected_value)
    style = (type == selected_type) ? "display:block;" : ""
		case type
  		when "boolean"
  			select_tag(:boolean_variable_value,options_for_select(values.map{|val| val.reverse},selected_value),prompt: "Seleciones una opcion", class: "demographic-query-value boolean-field", style: style)
      when "hash"
  		  select_tag(:hash_variable_value,options_for_select(values.map{|val| val.reverse},selected_value), prompt: "Seleciones una opcion", class: "demographic-query-value hash-field", style: style)
  	end
	end
end
