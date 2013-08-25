class ReportFilter < ActiveRecord::Base
  belongs_to :report
  belongs_to :research
  belongs_to :filtrble, polymorphic: true
end
