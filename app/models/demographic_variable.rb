class DemographicVariable < ActiveRecord::Base
  has_many :demographic_values
  has_many :results, :through => :demographic_values
  has_many :demographic_settings
  has_many :researches, :through => :demographic_settings
  validates :display_values, :presence => true, :demographic_type_format => true

  def self.demographic_types
  	{:boolean => "Valor booleano", :integer=> "Entero", :float => "Punto Flotante", :range=> "Rango de valores", :hash => "Lista de valores"}
  end

  def is_boolean?
  	accepted_value == "boolean"
  end

  def is_integer?
  	accepted_value == "integer"
  end

  def is_float?
  	accepted_value == "float"
  end

  def is_range?
  	accepted_value == "range"
  end

  def is_hash?
  	accepted_value == "hash"
  end

  def true_boolean_value
  	accepted_value == "boolean" ? display_values.split("|")[0] : nil
  end

  def false_boolean_value
  	accepted_value == "boolean" ? display_values.split("|")[1] : nil
  end

  def min_range_value
  	accepted_value == "range" ? display_values.split("-")[0].to_f : nil
  end

  def max_range_value
  	accepted_value == "range" ? display_values.split("-")[1].to_f : nil
  end

  def hash_value
  	accepted_value == "hash" ? display_values : nil
  end

  def hash_value_parsed
    accepted_value == "hash" ? JSON.parse("{#{display_values}}") : nil
  end

  def has_displayable_fields?
    is_boolean? or is_hash? or is_range?
  end

  def displayable_fields
    has_displayable_fields? ? ( is_boolean? ? [true_boolean_value,false_boolean_value] : hash_value_parsed.values ) : []
  end

  def queryable_values
    case accepted_value
      when "boolean"
        [["1", true_boolean_value],["0",false_boolean_value]]
      when "hash"
        hash_value_parsed.map{|h| [h.first.to_s,h.last]}
      when "range"
        [min_range_value,max_range_value]
      else
        []
    end
  end
end
