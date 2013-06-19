class QuestionSetting < ActiveRecord::Base
  belongs_to :research
  belongs_to :question

end
