class DemographicSetting < ActiveRecord::Base
  belongs_to :demographic_variable
  belongs_to :research
end
