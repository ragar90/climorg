class Question < ActiveRecord::Base
  belongs_to :dimension
  belongs_to :research
  has_many :answers
  has_many :results, :through => :answers 
  include ReportValues
  def barchart_values
  	self.ordinal
  end
  def ordinal_label
  	"Pregunta ##{self.ordinal}"
  end

  def barchart_label
    self.ordinal_label
  end
end
