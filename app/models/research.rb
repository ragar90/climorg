class Research < ActiveRecord::Base
  has_many :results
  has_many :demographic_settings
  has_many :demographic_variables, :through => :demographic_settings
  has_many :questions
  has_many :dimension_settings
  has_many :dimensions, :through => :dimension_settings
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

  def total_perception
    @total_perception ||= likeable_results(self.results.joins(:answers).group("answers.value").select("count(value) as total_likeable, value"))
  end

  def filter_by_dimensions(dimensions_ids = self.dimension_ids)
    _dimensions = dimensions.where(:id=>self.dimension_ids).group_by{|d| d.id}
    _results = self.results.joins(:answers=>:question).where("questions.dimension_id in (?)", dimensions_ids).group("questions.dimension_id, answers.value").select("dimension_id,value, count(value) as total_likeable, results.id").order("questions.dimension_id, answers.value").group_by{|result| result.dimension_id}
    _results.each_key do |key|
      _results[key] = {:dimension=>_dimensions[key].first,:results=>likeable_results(_results[key])}
    end
  end
  
  private
  
  def likeable_results(ungroup_results)
    data = {:likeable=>0,:unlikable=>0, :indiferent=>0}
    ungroup_results.each do |result|
      if result.value > 0 and result.value < 3
         data[:likeable]+= result.total_likeable
      elsif result.value >= 3 and result.value <= 4
        data[:unlikable]+= result.total_likeable
      else
        data[:indiferent]+= result.total_likeable
      end 
    end
    data
  end


  
end
