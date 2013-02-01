class Research < ActiveRecord::Base
  attr_accessible :company_name, :end_date, :start_date
  has_many :results
  has_many :demographic_settings
  has_many :demographic_variables, :through => :demographic_settings
  has_many :question_settings
  has_many :questions, :through => :question_settings
  has_many :dimension_settings
  has_many :dimensions, :through => :dimension_settings
end
