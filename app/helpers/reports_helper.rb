module ReportsHelper
	def filter_field(type,values)
		case type
		when "boolean"
			select_tag(:boolean_variable_value,options_for_select(values), class: "demographic-query-value boolean-field")
    when "hash"
			select_tag(:hash_variable_value,options_for_select(values), class: "demographic-query-value hash-field")
    when "range"
    	min_val = number_field_tag :min_range_variable_value,nil, class: "demographic-query-value range-field", :min=>0
    	max_val = number_field_tag :max_range_variable_value,nil, class: "demographic-query-value range-field", :min=>0
    	"#{min_val} - #{max_val}".html_safe
    when "integer"
    	number_field_tag :integer_variable_value,nil, class: "demographic-query-value integer-field", :min=>0
    when "float"
    	number_field_tag :float_variable_value,nil, class: "demographic-query-value float-field", :min=>0.0
		end
	end
end
