class Question < ActiveRecord::Base
  attr_accessible :description, :dimension_id, :is_default
  belongs_to :dimension
  has_many :question_settings
  has_many :researches, :through => :question_settings
  has_many :answers
  has_many :results, :through => :answers 
end
