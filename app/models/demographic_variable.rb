class DemographicVariable < ActiveRecord::Base
  attr_accessible :demographic_type_id, :display_values, :is_default, :name
  belongs_to :demographic_type
  has_many :demographic_values
  has_many :results, :throug => :demographic_values
  has_many :demographic_settings
  has_many :researches, :throug => :demographic_settings
end
