class Result < ActiveRecord::Base
  belongs_to :research
  has_many :demographic_values
  has_many :demographic_variables, :through => :demographic_values
  has_many :answers
  has_many :questions, :through => :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  accepts_nested_attributes_for :demographic_values, allow_destroy: true
end
