class Employee < ActiveRecord::Base
  has_many :evaluations
  has_many :researches, through: :evaluations

  def self.find_not_associated_to_research(research_id,employee_id)
  	unless Evaluation.exists?(research_id: research_id, employee_id: employee_id)
  		self.where(id:employee_id).first
  	else
  		nil
  	end
  end
end
