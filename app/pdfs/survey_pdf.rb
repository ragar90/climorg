class SurveyPdf < Prawn::Document
  def initialize(research, view, options = {})
    super(options)
    @research = research
    line_items
  end


  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..6).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      #self.column_widths = [10, 10, 10, 10, 10, 10]
    end
  end

  def line_item_rows
    [["Pregunta", "Completamente Insatisfactorio", "Insatisfactorio", "Satisfactorio","Completamente Satisfactorio", "No Aplica"]] +
    @research.survey.map do |question|
      [question.description, 1, 2, 3, 4, 0]
    end
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