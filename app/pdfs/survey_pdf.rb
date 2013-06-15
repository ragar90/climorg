class SurveyPdf < Prawn::Document
  def initialize(research, view, options = {})
    super(options)
    @research = research
    generate_document
  end
  
  def generate_document
    @research.survey.each do |question|
      render_question(question)
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