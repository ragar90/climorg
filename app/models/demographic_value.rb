class DemographicValue < ActiveRecord::Base
  belongs_to :demographic_variables
  belongs_to :result
end
