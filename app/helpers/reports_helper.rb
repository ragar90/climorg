module ReportsHelper
  def filter_field(type,values,selected_type, selected_value)
    style = (type == selected_type) ? "display:block;" : ""
		case type
  		when "boolean"
  			select_tag(:boolean_variable_value,options_for_select(values.map{|val| val.reverse},selected_value),prompt: "Seleciones una opcion", class: "demographic-query-value boolean-field", style: style)
      when "hash"
  		  select_tag(:hash_variable_value,options_for_select(values.map{|val| val.reverse},selected_value), prompt: "Seleciones una opcion", class: "demographic-query-value hash-field", style: style)
      when "range"
        min_val = selected_value.split("-").first rescue nil
        max_val = selected_value.split("-").last rescue nil
      	min_val_field = number_field_tag :min_range_variable_value,min_val, class: "demographic-query-value range-field", :min=>0, style: style, data:{brother: "#max_range_variable_value", range_value_type: "min_val"}
      	max_val_field = number_field_tag :max_range_variable_value,max_val, class: "demographic-query-value range-field", :min=>0, style: style,  data:{brother: "#min_range_variable_value", range_value_type: "max_val"} 
      	"#{min_val} - #{max_val}".html_safe
      when "integer"
      	number_field_tag :integer_variable_value,selected_value, class: "demographic-query-value integer-field", :min=>0, style: style
      when "float"
      	number_field_tag :float_variable_value,selected_value, class: "demographic-query-value float-field", :min=>0.0, style: style
  	end
	end
end
