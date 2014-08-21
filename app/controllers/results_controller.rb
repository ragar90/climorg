class ResultsController < ApplicationController
  before_filter :load_research, except: [:new_evaluation]
  def index
    @results = Result.filtered(@research.id).by_correlative.includes(:answers)
  end

  def new
    labels = ["Nada","Poco","Bastante","Muchisimio","No Aplica"]
    @answers = (0..4).map do |a|
      label = label[a]
      [label,a]
    end
    @result =   Result.new(research_id: @research.id)
    @result.research = @research
    @result.research_application = @application
    @result.init_values
  end

  def new_evaluation
    labels = ["Nada","Poco","Bastante","Muchisimio","No Aplica"]
    @answers = (0..4).map do |a|
      label = label[a]
      [label,a]
    end
    @research = Research.where(state: 3).first
    @application = @research.applications.first
    @result = Result.new(research_id: @research.id)
    @result.research = @research
    @result.research_application = @application
    @result.init_values
    render layout: false
  end

  def create
    @result = Result.new(permited_params(:result)) 
    
    respond_to do |format|
      if @result.save
        format.html{ redirect_to new_research_application_result_path(:research_id=>@research.id, application_id: @application.id), notice: "Resultado guardado exitosamente" }
      else
        qids = @result.answers.collect{|a| a.question_id}
        questions =  Question.where(:id=>qids).group_by(&:id)
        @result.answers.each do |ans|
          ans.question = questions[ans.question_id].first
        end
        format.html{ render action: "new", alert: "Hubo un problema al guardar el resultado anterior verifique los datos proporcionados" }
      end
    end
  end

  def edit
    @result = Result.find(params[:id])
  end

  def update
    @result = Result.find(params[:id])
    
    respond_to do |format|
      if @result.update_attributes(permited_params(:result))
        format.html{ redirect_to edit_research_result_path(:research_id=>@research.id, :id=>@result.id), notice: "Los Datos fueron actualizados correctamente" }
      else
        format.html{ render action: "edit", alert: "Hubo un problema al guardar el resultado anterior verifique los datos proporcionados" }
      end
    end
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    redirect_to research_results_path(:research_id=>@research.id)
  end
  
  private
  def load_research
    @research = current_organization.researches.where(id: params[:research_id]).includes(:dimensions).first
  end
end
