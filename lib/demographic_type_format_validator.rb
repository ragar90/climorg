class DemographicTypeFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    case object.accepted_value
    	when "boolean" then 
    		boolean_validator(object, attribute, value)
    	#when "integer" then 
    	#	integer_validator(object, attribute, value)
    	#when "float" then 
    	#	float_validator(object, attribute, value)
    	when "range" then 
    		range_validator(object, attribute, value)
    	when "hash" then 
    		hash_validator(object, attribute, value)
    	else
    end
  end

  def boolean_validator(object, attribute, value)
  	unless value =~/^\w+\|\w+$/
  		object.errors[attribute] << (options[:message] || "No se encuentra con el formato adecuado para una variable booleana") 
  	end
  end

  def integer_validator(object, attribute, value)
  	unless value !~/\D+/
  		object.errors[attribute] << (options[:message] || "No se encuentra con el formato adecuado para una variable entera") 
  	end
  end

  def float_validator(object, attribute, value)
  	unless value =~/^\d+\.\d+$/
  		object.errors[attribute] << (options[:message] || "No se encuentra con el formato adecuado para una variable de punto flotante") 
  	end
  end

  def range_validator(object, attribute, value)
  	unless value =~/^(\d|\d\.\d)+\-(\d|\d\.\d)+$/
  		object.errors[attribute] << (options[:message] || "No se encuentra con el formato adecuado para un rango numerico") 
  		return
  	end
  	values = value.split("-")
  	min = (values[0]=~/^\d+\.\d+$/) ? values[0].to_f : values[0].to_i
  	max = (values[1]=~/^\d+\.\d+$/) ? values[1].to_f : values[1].to_i
  	unless min<max
  		object.errors[attribute] << (options[:message] || "Rango de valores no validos") 
  		return
  	end
  end

  def hash_validator(object, attribute, value)#
  	unless value =~ /^("\w+":"(\w+|\s)*",*\s?)+\z$/
      object.errors[attribute] << (options[:message] || "No se encuentra con el formato adecuado para una lista de valores, el formato debe ser una lista pares separada por \",\" los pares deben de ingresarse de la forma \"llave\":\"valor\" Ejemplo \"llave1\":\"valor1\",\"llave2\":valor2\"")   
  	end
  end

end

