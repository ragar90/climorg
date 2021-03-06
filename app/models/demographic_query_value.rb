class DemographicQueryValue
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :condition_value, :variable_type, :condition_value_label
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def to_qprm
    unless condition_value
      ""
    else
      conditions =  self.query_values
      if conditions.length == 1
          ["demographic_value = ?", conditions.first]
      else
        case variable_type
        when "hash"
          ["demographic_value in (?)", conditions]
        when "range" || "float" || "integer"
          ["demographic_value >=  ? and demographic_value <= ? ", conditions.first, conditions.last]          
        end
        
      end
    end
  end
  
  def query_values
    case condition_value
    when /\d+-\d+/ #Number
      @query_values ||= condition_value.split("-").map{|d| d.to_i }.sort
    when /^(\d+\.\d+)+\-(\d+\.\d+)+$/
      @query_values ||= condition_value.split("-").map{|d| d.to_f }.sort
    when /(\w+,)|\w+/#Hash
      @query_values ||= condition_value.split(",")
    else #Exact Value
      @query_values ||= [condition_value]
    end
  end
end