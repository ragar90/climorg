module ReportValues
  extend ActiveSupport::Concern

  def barchart_label
  	self.id.to_s
  end
end