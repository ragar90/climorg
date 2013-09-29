class Hash
  def to_barchart_data
    new_hash = Hash.new
    
    self.each_value do |hash|
      hash[:results] = hash[]
    end
  end
end