class QuestionSetting < ActiveRecord::Base
  attr_accessible :question_id, :research_id
  belongs_to :research
  belongs_to :question

end
