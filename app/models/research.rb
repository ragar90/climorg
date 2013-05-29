class Research < ActiveRecord::Base
  has_many :results
  has_many :demographic_settings
  has_many :demographic_variables, :through => :demographic_settings
  #has_many :question_settings
  has_many :questions#, :through => :question_settings
  has_many :dimension_settings
  has_many :dimensions, :through => :dimension_settings
  validates :company_name,:start_date, :presence => true
  validate :start_and_end_date_consistency 
  #accepts_nested_attributes_for :questions, allow_destroy: true
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
    self.state = 3
    self.save
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
  
end
