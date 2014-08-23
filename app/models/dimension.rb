class Dimension < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :dimension_settings
  has_many :researches, :through => :dimension_settings
  validates :name, :presence=>true
  validates :name, :uniqueness => { :case_sensitive => false }
  include ReportValues
  def barchart_label
  	self.name.titleize
  end

  def camelize_name
  	name.camelize unless name.nil?
  end
end
