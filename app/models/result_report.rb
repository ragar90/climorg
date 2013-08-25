class ResultReport < ActiveRecord::Base
  belongs_to :research
  belongs_to :result
  belongs_to :question
  belongs_to :answer
  belongs_to :dimension
  belongs_to :demographic_value
  belongs_to :demographic_variable
end