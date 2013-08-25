class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :result
  validates :value, :presence=>true
  
  def likeable_type
    if value >= 1 and value <=2
      :likeable
    elsif value >= 3 and value <=4
      :unlikeable
    else
      :indiferent
    end
  end

  def to_s
    "Answer ##{question.ordinal}"
  end
end
