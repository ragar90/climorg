class Question < ActiveRecord::Base
  attr_accessible :description, :dimension_id, :is_default, :research_id
  belongs_to :dimension
  #has_many :question_settings
  belongs_to :research#, :through => :question_settings
  has_many :answers
  has_many :results, :through => :answers 
end
