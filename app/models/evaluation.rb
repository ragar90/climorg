class Evaluation < ActiveRecord::Base
	belongs_to :research
	belongs_to :employee
	has_one :result
end
