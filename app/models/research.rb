class Research < ActiveRecord::Base
  belongs_to :organization
  has_many :results
  has_many :demographic_settings
  has_many :demographic_variables, :through => :demographic_settings
  has_many :questions
  has_many :dimension_settings
  has_many :dimensions, :through => :dimension_settings
  has_many :reports
  has_many :evaluations
  has_many :employees, through: :evaluations

  validates :organization, :start_date, :presence => true
  validate :start_and_end_date_consistency

  accepts_nested_attributes_for :questions, allow_destroy: true

  scope :only_parents, -> {where(parent_id:nil)}
  scope :only_active, ->{where(is_conclude:false)}
  scope :results_group_by_answer, -> { results.joins(:answers).group("answers.value").select("count(value) as total_likeable, value")}

  include Reportable

  def start_and_end_date_consistency
    unless (!start_date.nil? and !end_date.nil?) and start_date < end_date
    	errors.add(:start_date, "No puede ser despues de la fecha de finalizacion")
    	errors.add(:end_date, "No puede ser antes de la fecha de inicio")
    end
  end

  def test
    self.questions.where(is_active:true)
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

  def state_label
    case state
      when 0 then "Creado"
      when 1 then "Configurado"
      when 2 then "Con Cuestionario"
      when 3 then "Confirmado"
      else
        "Ninguno"
    end
  end

  def state_label_color
    case state
      when 1 then "warning"
      when 2 then "info"
      when 3 then "success"
      else
        ""
    end
  end

  def label
    "Estudio #{self.formated_start_date} - #{self.formated_end_date}"
  end

  def formated_start_date
    self.start_date.strftime("%d/%m/%y")
  end

  def formated_end_date
    self.end_date.strftime("%d/%m/%y")
  end

  def survey
    self.test.order(:ordinal)
  end

  def current_application
    self.applications.where(number: self.applications.count).first
  end

  def variables_values
    query_values =
    self.demographic_variables.active.map do |v|
      query_values = v.queryable_values.map { |value| DemographicQueryValue.new(condition_value:value.first,condition_value_label:value.last,variable_type: v.accepted_value) rescue DemographicQueryValue.new(variable_type: v.accepted_value)  }
      {id:v.id,queryable_values: query_values }
    end
  end

  def grouped_questions
    @grouped_questions ||= self.test.where(is_active:true).order(:ordinal).group_by(&:dimension_id)
  end

  def organization_name
    self.organization.name
  end
end
