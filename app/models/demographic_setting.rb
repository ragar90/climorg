class DemographicSetting < ActiveRecord::Base
  attr_accessible :demographic_variable_id, :research_id
  belongs_to :demographic_variable
  belongs_to :research
end
