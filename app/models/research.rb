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

end
