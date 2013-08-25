class Question < ActiveRecord::Base
  belongs_to :dimension
  belongs_to :research
  has_many :answers
  has_many :results, :through => :answers 
  has_many :report_filters, as: :filtrable
  
end
