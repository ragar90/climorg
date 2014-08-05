class Report
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :research_id, :dimension_ids, :demographic_variable_ids, :query,
                :show_questions, :title

  def initialize(params = {})
    if params.length == 0
      self.dimension_ids = []
      self.demographic_variable_ids = []
      self.show_questions = false
    else
    	params.each do |attribute, value|
        none_blank_params = params[:query].values.select{|val| !val.blank?}
        if attribute.to_s == "query" and none_blank_params.length != 0
          self.query = DemographicQueryValue.new(params[:query])
        elsif attribute != "query"
          self.send("#{attribute}=",value)  
        end
    	end
      self.query ||= DemographicQueryValue.new
    end
  end

  def report_method
    dimension_ids = self.dimension_ids.length > 0 ? self.dimension_ids : nil
    demographic_variable_ids = self.demographic_variable_ids.length > 0 ? self.demographic_variable_ids : nil
    params = {questions: self.show_questions,dimension_id: dimension_ids,variable_id: demographic_variable_ids,query_value: self.query}
    dimension_ids.nil? ? [:total_perception, params] : [:filter_by_dimensions,params]
  end

  def set_title(params)
    title_1 = ""
    title_2 = ""
    title_3 = ""
    if !params[:report][:dimension_ids].blank?
      dimension_id = params[:report][:dimension_ids]
      title_1 = Dimension.where(id:dimension_id).first.name
      if params[:report][:show_questions]
        title_2 = "por Preguntas"
      end
      if !params[:report][:demographic_variable_ids].blank?
        variable_id = params[:report][:demographic_variable_ids]
        variable = DemographicVariable.where(id:variable_id).first
        variable_value_key = params.to_a.select{|pair| pair.first =~ /\w+_value/ and !pair.last.blank?}.first
        #ss.ss
        unless variable_value_key.nil?
          variable_value = variable_value_key.last
          variable_value_label = variable.label_for_value(variable_value)
          title_3 = "#{variable_value_label.pluralize.titleize}"
        else
          title_3 = "por #{variable.name.titleize}"
        end  
        self.title = "#{title_1} #{title_3} #{title_2}"
      end
    elsif !params[:report][:demographic_variable_ids].blank?
      variable_id = params[:report][:demographic_variable_ids]
      variable = DemographicVariable.where(id:variable_id).first
      variable_value_key = params.to_a.select{|pair| pair.first =~ /\w+_value/ and !pair.last.blank?}.first
      unless variable_value_key.nil?
        variable_value = variable_value_key.last
        variable_value_label = variable.label_for_value(variable_value)
        title_3 = "#{variable_value_label.pluralize.titleize}"
      else
        title_3 = "#{variable.name.titleize}"
      end
      self.title = "Resultados por #{title_3} #{title_2}"
    end
  end

  def titleize
    self.title.titleize rescue nil
  end
end