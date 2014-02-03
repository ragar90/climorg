module ReportsHelper
	def filter_field(type,values, show_demographic, demographic_type)
		case type
    		when "boolean"
                style = (show_demographic == "1" and (demographic_type.include?("boolean") rescue false)) ? "display:block" : ""
    			select_tag(:boolean_variable_value,options_for_select(values.map{|val| val.reverse}), class: "demographic-query-value boolean-field", style: style)
            when "hash"
                style = (show_demographic == "1" and (demographic_type.include?("hash") rescue false)) ? "display:block" : ""
        		select_tag(:hash_variable_value,options_for_select(values.map{|val| val.reverse}), class: "demographic-query-value hash-field")
            when "range"
                style = (show_demographic == "1" and (demographic_type.include?("range") rescue false) )? "display:block" : ""
            	min_val = number_field_tag :min_range_variable_value,nil, class: "demographic-query-value range-field", :min=>0, style: style
            	max_val = number_field_tag :max_range_variable_value,nil, class: "demographic-query-value range-field", :min=>0, style: style
            	"#{min_val} - #{max_val}".html_safe
            when "integer"
                style = (show_demographic == "1" and (demographic_type.include?("integer") rescue false)) ? "display:block" : ""
            	number_field_tag :integer_variable_value,nil, class: "demographic-query-value integer-field", :min=>0, style: style
            when "float"
                style = (show_demographic == "1" and (demographic_type.include?("float") rescue false)) ? "display:block" : ""
            	number_field_tag :float_variable_value,nil, class: "demographic-query-value float-field", :min=>0.0, style: style
    	end
	end
end
