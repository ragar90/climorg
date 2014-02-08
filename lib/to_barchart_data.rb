class Hash
  def to_barchart_data
    self.map{|k,v| [(v.values.first.barchart_label rescue v.values.first), v[:results].values.first]}.sort{|a,b| a.first<=>b.first}
  end

  def to_multisieres_barchart_data
    
  end
end