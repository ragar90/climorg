class Result < ActiveRecord::Base
  scope :filtered, ->(research_id){ where(:research_id=>research_id)}
  scope :by_correlative, -> { order(:correlative)}
  belongs_to :research
  has_many :demographic_values
  has_many :demographic_variables, :through => :demographic_values
  has_many :answers
  has_many :questions, :through => :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  accepts_nested_attributes_for :demographic_values, allow_destroy: true
  before_create :asign_correlative
  
  def asign_correlative
    total_results = Result.where(:research_id=>self.research_id).count
    self.correlative = total_results+1
  end
  
  def init_values
    if self.answers.count == 0
      self.research.survey.each do |question|
        self.answers << Answer.new(question_id: question.id)
      end
    end
    
    if self.demographic_values.count == 0
      self.research.demographic_variables.each do |variable|
        self.demographic_values << DemographicValue.new(demographic_variable_id: variable.id)
      end
    end
  end
end
