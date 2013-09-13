class DemographicValue < ActiveRecord::Base
  belongs_to :demographic_variable
  belongs_to :result
  validates :value, :presence=>true
  validate :value_type
  alias_method :variable, :demographic_variable
  attr_accessor :condition_value
  def value_type
    if demographic_variable.is_boolean?
      unless self.value == "1" || self.value == "true" || self.value == "0" || self.value == "false"
        self.errors[:value] << "Error en el valor de esta variable, se esperaba cualquiera de estos valores \"1\", \"0\",\"true\",\"false\" y se recibio #{self.value}"
      end
    elsif demographic_variable.is_integer? 
      unless self.value !~/\D+/
        self.errors[:value] << "Error en el valor de esta variable, se esperaba un valor entero y se recibio #{self.value}"
      end
    elsif demographic_variable.is_float?
      unless self.value =~/^\d+\.\d+$/
        self.errors[:value] << "Error en el valor de esta variable, se esperaba un numero decimal y se recibio #{self.value}"
      end
    elsif demographic_variable.is_range?
      val = self.value.to_f
      max_val = demographic_variable.max_range_value
      min_val = demographic_variable.min_range_value
      unless val>=min_val and val<=max_val
        self.errors[:value] << "Error en el valor de esta variable, se esperaba un numero dentro del rango #{min_val}-#{max_val}"
      end
    else
      unless !demographic_variable.hash_value_parsed[self.value].nil?
        self.errors[:value] << "Error en el valor de esta variable, el valor proporcionado no se encuentra dentro de la lista de valores"
      end
    end
  end
  
  def typed_value(val=self.value)
    case demographic_variable.accepted_value
    when "boolean"
      (val == "1" || val == "true") ? demographic_variable.true_boolean_value : ((val == "0" || val == "false") ? demographic_variable.false_boolean_value : nil )
    when "integer"
      val.to_id
    when "float" || "range"
      val.to_f
    when "hash"
      demographic_variable.hash_value_parsed[val]
    else
      ""
    end
  end

  def to_s
    demographic_variable.name
  end
end
