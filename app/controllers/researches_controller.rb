class ResearchesController < ApplicationController
  before_filter :load_change_state
  # GET /researches
  # GET /researches.json
  def index
    @researches = Research.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @researches }
    end
  end

  # GET /researches/1
  # GET /researches/1.json
  def show
    @research = Research.find(params[:id])
    @dimensions_reports = @research.filter_by_dimensions
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @research }
    end
  end

  # GET /researches/new
  # GET /researches/new.json
  def new
    @research = Research.new
    @current_state = @research.state || 0
    @research.state += 1 if  @research.state < 2
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @research }
    end
  end

  # GET /researches/1/edit
  def edit
    @research = Research.find(params[:id])
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
    @research = Research.new(permited_params(:research).permit!)
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
    @research = Research.find(params[:id])
    if @research.is_confirmed?
      redirect_to researches_path, notice: 'Este estudio ya fue confirmado por lo que no se puede editar.'
      return
    end
    respond_to do |format|
      if @research.update_attributes(permited_params(:research).permit!)
        format.html { redirect_to edit_research_path(id: @research.id), notice: 'Research was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @research = Research.find(params[:id])
    
    respond_to do |format|
      if @research.confirm!
        format.html { redirect_to researches_path, notice: 'Research was successfully confirmed.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", flash: "El Estudio no pudo confirmarse adecuadamente" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researches/1
  # DELETE /researches/1.json
  def destroy
    @research = Research.find(params[:id])
    @research.destroy

    respond_to do |format|
      format.html { redirect_to researches_url }
      format.json { head :no_content }
    end
  end
  
  def survey
    @research = Research.find(params[:id])
    respond_to do |format|
      format.html { render "survey", :layout=>"pdf"}
      format.pdf do
        pdf = SurveyPdf.new(@research, view_context)
        send_data pdf.render,filename: "#{@research.company_name}_cuestionario",type: "application/pdf",disposition: "inline"
      end
    end
  end
  
  private 

  def load_change_state
    @change_state = params[:change_state] == "true"
  end 
end
