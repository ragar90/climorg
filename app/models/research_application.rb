class ResearchApplication < ActiveRecord::Base
  belongs_to :research
  has_many :results
  before_create :set_application_number

  def set_application_number
    self.number = ResearchApplication.where(research_id: self.research_id).count + 1
  end
end
