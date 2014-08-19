class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    @research = Research.find(params[:id])
    @dimension = Dimension.find(params[:dimension_id])
    respond_to do |format|
      format.html do
        @questions = @research.questions.where(dimension_id: params[:dimension_id])
        render :layout=>false
      end
      format.pdf do
        if params[:dimension_id].nil?
          render :file => "#{Rails.root}/public/404.html",  :status => 404
        else
          @survey = @research.test.where(dimension_id: params[:dimension_id])
          pdf = SurveyPdf.new(@research, view_context, survey:@survey)
          send_data pdf.render,filename: "#{@research.organization_name}_cuestionario_dimension_#{@dimension.name}",type: "application/pdf",disposition: "inline"
        end
        
      end
    end
  end
end
