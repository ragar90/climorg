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
end
