class ResearchesController < ApplicationController
  before_filter :load_change_state
  # GET /researches
  # GET /researches.json
  def index
    @researches = current_organization.researches
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @researches }
    end
  end

  # GET /researches/1
  # GET /researches/1.json
  def show
    @research = current_organization.researches.find(params[:id])
    @demographic_reports = []
    variables = @research.variables_values
    i = 0
    variables.each do |variable|
      variable[:queryable_values].each_with_index do |value,j|
        data = @research.total_perception(variable_id: variable[:id],query_value: value )
        percent = (((data[:results][:likeable] * 1.0) / data[:results].values.inject { |sum,x| sum + x  }) * 100.0).round(2)
        @demographic_reports <<  [variable[:queryable_values][j].condition_value_label, percent]
        i+=1
        if i == 3
          break
        end
      end
      if i == 3
        break
      end
    end
    @dimensions = @research.filter_by_dimensions
    @dimensions_reports = [["Dimensiones","Satisfactorio"]] + @dimensions[:results].to_barchart_data
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @research }
    end
  end

  # GET /researches/new
  # GET /researches/new.json
  def new
    @research = Research.new
    @research.user_id = current_user.id
    @current_state = @research.state || 0
    @research.state += 1 if  @research.state < 2
    @research.organization_id = current_organization.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @research }
    end
  end

  # GET /researches/1/edit
  def edit
    @research = current_organization.researches.find(params[:id])
    @grouped_questions = @research.grouped_questions
    @dimensions = @research.dimensions
    @employees = @research.employees
    if @research.is_confirmed?
      redirect_to researches_path, notice: 'Este estudio ya fue confirmado por lo que no se puede editar.'
      return
    end
    @current_state = @research.state || 0
    @research.state += 1 if  @research.state < 2
  end

  # POST /researches
  # POST /researches.json
  def create
    @research = Research.new(permited_params(:research))
    respond_to do |format|
      if @research.save
        format.html { redirect_to edit_research_path(id: @research.id), notice: 'Research was successfully created.' }
        format.json { render json: @research, status: :created, location: @research }
      else
        format.html { render action: "new" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /researches/1
  # PUT /researches/1.json
  def update
    @research = current_organization.researches.find(params[:id])
    if @research.is_confirmed?
      redirect_to researches_path, notice: 'Este estudio ya fue confirmado por lo que no se puede editar.'
      return
    end
    @ok = true
    Research.transaction do
      begin
        @ok = @research.update_attributes(permited_params(:research).permit!) and @ok
        unselected_ids = params[:unselected_ids].split(",") rescue []
        selected_ids = params[:selected_ids].split(",") rescue []
        @research.questions.where(dimension_id: unselected_ids).update_all(is_active: false)
        @research.questions.where(dimension_id: selected_ids).update_all(is_active: true)
      end
    end
    @current_state = @research.state || 0
    respond_to do |format|
      if @ok
        format.html { redirect_to edit_research_path(id: @research.id), notice: 'Research was successfully updated.' }
        format.json { head :no_content }
      else
        @grouped_questions = @research.grouped_questions
        @dimensions = @research.dimensions
        @current_state = @research.state || 0
        format.html { render action: "edit" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @research = current_organization.researches.find(params[:id])
    respond_to do |format|
      if @research.confirm!
        @current_state = @research.state
        format.html { redirect_to researches_path, notice: 'Research was successfully confirmed.' }
        format.json { head :no_content }
      else
        @current_state = @research.state
        format.html { render action: "edit", flash: "El Estudio no pudo confirmarse adecuadamente" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researches/1
  # DELETE /researches/1.json
  def destroy
    @research = current_organization.researches.find(params[:id])
    @research.destroy

    respond_to do |format|
      format.html { redirect_to researches_url }
      format.json { head :no_content }
    end
  end
  
  def survey
    @research = current_organization.researches.find(params[:id])
    respond_to do |format|
      format.html { render "survey", :layout=>"pdf"}
      format.pdf do
        pdf = SurveyPdf.new(@research, view_context)
        send_data pdf.render,filename: "#{@research.organization_name}_cuestionario",type: "application/pdf",disposition: "inline"
      end
    end
  end
  
  private 

  def load_change_state
    @change_state = params[:change_state] == "true"
  end 
end
