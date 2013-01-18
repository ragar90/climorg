class DemographicType < ActiveRecord::Base
  attr_accessible :acsepted_values, :name
  has_many :demographic_variables
end
