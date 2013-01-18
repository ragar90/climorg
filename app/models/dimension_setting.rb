class DimensionSetting < ActiveRecord::Base
  attr_accessible :dimension_id, :research_id
  belongs_to :research
  belongs_to :dimension
end
