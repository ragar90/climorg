class Answer < ActiveRecord::Base
  attr_accessible :question_id, :result_id, :value
  belongs_to :question
  belongs_to :result
end
