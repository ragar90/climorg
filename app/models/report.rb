class Report < ActiveRecord::Base
  belongs_to :research
  has_many :report_filters
end
