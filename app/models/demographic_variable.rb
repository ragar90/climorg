class DemographicVariable < ActiveRecord::Base
  attr_accessible :demographic_type_id, :display_values, :is_default, :name
  has_many :demographic_values
  has_many :results, :through => :demographic_values
  has_many :demographic_settings
  has_many :researches, :through => :demographic_settings

  def self.demographic_types
  	{:boolean => "Valor booleano", :integer=> "Entero", :float => "Punto Flotante", :range=> "Rango de valores", :hash => "Lista de valores"}
  end
end
