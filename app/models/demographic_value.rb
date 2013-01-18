class DemographicValue < ActiveRecord::Base
  attr_accessible :demographi_variable_id, :result_id, :value
  belongs_to :demographic_variables
  belongs_to :result
end
