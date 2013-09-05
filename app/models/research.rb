class Research < ActiveRecord::Base
  has_many :results
  has_many :demographic_settings
  has_many :demographic_variables, :through => :demographic_settings
  has_many :questions
  has_many :dimension_settings
  has_many :dimensions, :through => :dimension_settings
  has_many :reports
  has_many :report_filters
  validates :company_name,:start_date, :presence => true
  validate :start_and_end_date_consistency 
  accepts_nested_attributes_for :questions, allow_destroy: true
  
  scope :results_group_by_answer, -> { results.joins(:answers).group("answers.value").select("count(value) as total_likeable, value")}
  
  
  def start_and_end_date_consistency 
    unless (!start_date.nil? and !end_date.nil?) and start_date < end_date
    	errors.add(:start_date, "No puede ser despues de la fecha de finalizacion")
    	errors.add(:end_date, "No puede ser antes de la fecha de inicio")
    end
  end
  
  def is_draft?
    self.state!=3
  end
  #0=>creado
  #1=>configurado
  #2=>con cuestionario
  #3=>confirmado
  def state_label
    self.state == 3 ? "Confirmado" : "Borrador"
  end

  def confirm!
    unless self.questions.length == 0
      saved = true
      self.transaction do
        begin
          self.state = 3
          i = 1
          self.questions.shuffle.each do |question|
            question.ordinal=i
            saved = saved && question.save  
            i+=1
            break if !saved
          end
          saved = saved && self.save 
          raise ActiveRecord::Rollback if !saved
        rescue
          ActiveRecord::Rollback
          saved = false
        end
      end
      return saved
    else
      return false
    end
  end
  
  def is_confirmed?
    self.state == 3
  end
  
  def next_step?
     state_label(self.is_draft? ? self.state + 1 : nil)
  end

  def current_state
    state_label(self.state)
  end
  
  def state_label(state)
    case state
      when 0 then "Creado"
      when 1 then "Configurado"
      when 2 then "Con Cuestionario"
      when 3 then "Confirmado"
      else 
        "Ninguno"
    end
  end
  
  def survey
    self.questions.order(:ordinal)
  end

  # Global data
  
  def report(demographic_variable_id,demographic_query_value)
    demographic_variable_id ||=  self.demographic_variable_ids.first
    select_fields = "results.research_id as research_id,results.id as result_id,results.correlative as result_correlative,answers.question_id as question_id,questions.description as question_description,answers.id as answer_id,answers.value as answer_value,questions.ordinal as question_ordinal,questions.dimension_id as dimension_id,dimensions.name as dimension_name,demographic_values.value as demographic_value,demographic_values.demographic_variable_id as demographic_variable_id,demographic_variables.name as demographic_variable_name"
    unless demographic_query_value
      results.joins(answers: {question: :dimension}, demographic_values: :demographic_variable).select(select_fields).where("demographic_variables.id = ?",demographic_variable_id)
    else
      params = demographic_query_value.to_qprm
      #Falta integrar los parametros con toda la consulta
      results.joins(answers: {question: :dimension}, demographic_values: :demographic_variable).select(select_fields).where("demographic_variables.id = ? and #{params.first}",demographic_variable_id,params.last)
    end
    
  end
  
  def total_perception(demographic_variable_id =  nil, demographic_query_value = nil)
    unless demographic_query_value
      @total_perception ||= likeable_results(self.report(demographic_variable_id).group("answers.value").select("count(answers.value) as total_likeable, answers.value"))
    else
      results = self.report(demographic_variable_id).where(demographic_query_value.to_qprm).group("answers.value").select("count(answers.value) as total_likeable, answers.value")
      likeable_results(results)
    end
    
  end
  
  def filter_by_questions(questions_ids = self.question_ids, demographic_variable_id =  nil, demographic_query_value = nil)
    unless @results_by_questions
      _questions = questions.group_by{|d| d.id}
      _results = report(demographic_variable_id).group("questions.id, answers.value").select("questions.id as question_id,answers.value as value, count(answers.value) as total_likeable, results.id as result_id").order("questions.id, answers.value").group_by{|result| result.question_id}
      _results.each_key do |key|
        _results[key] = {:question=>_questions[key].first,:results=>likeable_results(_results[key])}
      end
      @results_by_questions = _results
    else
      @results_by_questions
    end
  end
  
  # Global data by dimension
  def filter_by_dimensions(dimensions_ids = self.dimension_ids, demographic_variable_id =  nil, demographic_query_value = nil)
    unless @results_by_dimensions
      _dimensions = dimensions.group_by{|d| d.id}
      _results = report(demographic_variable_id).group("questions.dimension_id, answers.value").select("questions.dimension_id,answers.value as value, count(answers.value) as total_likeable, results.id").order("questions.dimension_id, answers.value").group_by{|result| result.dimension_id}
      _results.each_key do |key|
        _results[key] = {:dimension=>_dimensions[key].first,:results=>likeable_results(_results[key])}
      end
      @results_by_dimensions = _results
    else
      @results_by_dimensions
    end
  end
  
  private
  
  def likeable_results(ungroup_results)
    data = {:likeable=>0,:unlikable=>0, :indiferent=>0}
    ungroup_results.each do |result|
      if result.value > 0 and result.answer_value < 3
         data[:unlikable]+= result.total_likeable
      elsif result.value >= 3 and result.answer_value <= 4
        data[:likeable]+= result.total_likeable
      else
        data[:indiferent]+= result.total_likeable
      end 
    end
    data
  end


  
end
