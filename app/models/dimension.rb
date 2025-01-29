class Dimension < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :dimension_settings
  has_many :researches, :through => :dimension_settings
  has_many :dimension_variables
  validates :name, :presence=>true
  validates :name, :uniqueness => { :case_sensitive => false }

  accepts_nested_attributes_for :dimension_variables, allow_destroy: true

  scope :active, -> {where(is_active:true)}
  scope :defaults, -> { self.active.where(is_default:true) }
  include ReportValues
  def barchart_label
  	self.name.titleize
  end

  def camelize_name
  	name.camelize unless name.nil?
  end
end
