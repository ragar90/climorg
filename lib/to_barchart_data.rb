class Hash
  def to_barchart_data
    self.map{|k,v| [v.values.first.ordinal, v[:results].values.first]}.sort{|a,b| a.first<=>b.first}  rescue nil
  end
end