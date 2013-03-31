class Research < ActiveRecord::Base
  attr_accessible :company_name, :end_date, :start_date,:demographic_variable_ids, :dimension_ids, :question_ids
  has_many :results
  has_many :demographic_settings
  has_many :demographic_variables, :through => :demographic_settings
  has_many :question_settings
  has_many :questions, :through => :question_settings
  has_many :dimension_settings
  has_many :dimensions, :through => :dimension_settings
  validates :company_name,:start_date, :presence => true
  validate :start_and_end_date_consistency 
  def start_and_end_date_consistency 
    unless (!start_date.nil? and !end_date.nil?) and start_date < end_date
    	errors.add(:start_date, "No puede ser despues de la fecha de finalizacion")
    	errors.add(:end_date, "No puede ser antes de la fecha de inicio")
    end
  end
end
