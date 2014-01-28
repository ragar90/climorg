class Question < ActiveRecord::Base
  belongs_to :dimension
  belongs_to :research
  has_many :answers
  has_many :results, :through => :answers 
  include ReportValues
  def barchart_values
  	self.ordinal
  end
end
