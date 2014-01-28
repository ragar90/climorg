class Hash
  def to_barchart_data
    self.map{|k,v| [v.values.first.barchart_label, v[:results].values.first]}.sort{|a,b| a.first<=>b.first}
  end
end