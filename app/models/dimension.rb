class Dimension < ActiveRecord::Base
  attr_accessible :is_default, :name
  has_may :questions
  has_many :dimensio_settings
  has_many :researches, :throug => :dimensio_settings
end
