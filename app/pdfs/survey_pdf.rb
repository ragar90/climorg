class SurveyPdf < Prawn::Document
  def initialize(research, view, options = {})
    options[:top_margin] = 60
    super(options)
    @research = research
    @survey = options[:survey] || @research.survey
    generate_document
  end
  
  def generate_document
    render_survey
  end
  
  def render_survey
    repeat :all do
      canvas do
        bounding_box [bounds.left, bounds.top], :width  => bounds.absolute_left + bounds.absolute_right,:height => 200 do
          move_down 20
          text @research.organization_name.titleize, :align => :center,:style => :bold, :size=>16
          move_down 10
          text "Encuesta de Clima Organizacional", :align => :center,:style => :bold, :size=>16
          text @research.start_date.strftime("%B %Y"), :align => :center,:style => :bold, :size=>16
        end
      end
    end
    bounding_box([bounds.left, bounds.top - 50], :width  => bounds.width) do
      text "Cuestionario #<color rgb='FFFFFF'>999999999999999</color>", :size=>11,:align => :right,:inline_format => true
      render_indications_header
      render_questions
    end
  end
  
  def render_indications_header
    instructions = "Marque con una “X” la opción que mejor describe su preferencia respecto a cada una de las afirmaciones. Únicamente marque una opción para cada afirmación."
    data = [ ["#",instructions, "1", "2", "3","4", "No Aplica"] ]
    table(data,:cell_style => { :size => 10 }) do
      column(0).style(:align => :justify, :valign => :center)
      column(0).width = 30                                  
      column(0).style(:align => :center, :valign => :center)
      column(1).width = 250
      column(2..6).style(:align => :center, :valign => :center)
      column(2..6).width = 50                                  
      column(2..6).style(:align => :center, :valign => :center)
      row(0).border_width = 1
      row(0).font_style = :bold
    end
  end
  
  def render_questions
    move_down 20
    data = [ ]
    @survey.each do |question|
      data << ["#{question.ordinal}","<font size='9.5'>#{question.description}</font>", "Nada", "Poco", "Bastante","Muchisimo", "No Aplica"]
    end
    table(data,:cell_style => { :inline_format => true }) do
      column(0).style(:align => :justify, :valign => :center)
      column(0).width = 30                                  
      column(0).style(:align => :center, :valign => :center)
      column(1).width = 250
      column(2..6).width = 50
      column(2..6).style(:align => :center, :valign => :center, :size=>7)
    end
  end
  
  def render_question(question)
    group do
      text question.description
      move_down 10
      text "Muy Malo  ", :indent_paragraphs => 20
      bounding_box([85, cursor+15], :width => 10,:height => 10) do
        stroke_bounds
      end
      text "\n"
      text "Malo", :indent_paragraphs => 20
      bounding_box([85, cursor+15], :width => 10,:height => 10) do
        stroke_bounds
      end
      text "\n"
      text "Bueno", :indent_paragraphs => 20
      bounding_box([85, cursor+15], :width => 10,:height => 10) do
        stroke_bounds
      end
      text "\n"
      text "Muy Bueno", :indent_paragraphs => 20
      bounding_box([85, cursor+15], :width => 10,:height => 10) do
        stroke_bounds
      end
      text "\n"
      text "No Aplica", :indent_paragraphs => 20
      bounding_box([85, cursor+15], :width => 10,:height => 10) do
        stroke_bounds
      end
      text "\n"
      move_down 10
    end
  end
end