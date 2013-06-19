class Dimension < ActiveRecord::Base
  has_many :questions
  has_many :dimensio_settings
  has_many :researches, :through => :dimension_settings
  validates :name, :presence=>true
  validates :name, :uniqueness => { :case_sensitive => false }
  def camelize_name
  	name.camelize unless name.nil?
  end
end
