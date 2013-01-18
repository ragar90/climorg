class Result < ActiveRecord::Base
  attr_accessible :research_id
  belongs_to :research
  has_many :demographic_values
  has_many :demographic_variables, :through => :demographic_values
  has_many :answers
  has_many :questions, :throug => :answers
end
