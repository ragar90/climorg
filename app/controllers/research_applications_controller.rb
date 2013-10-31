class ResearchApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  def index
    @research_applications = @research.applications
  end

  # GET /applications/1
  def show
  end

  # GET /applications/new
  def new
    @last_application = @research.current_application
    @last_application.is_conclude = true
    @last_application.save
    @research_application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  def create
    @research_application = Application.new(research_application_params)

    if @research_application.save
      redirect_to @research_application, notice: 'Application was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @research_application.update(research_application_params)
      redirect_to @research_application, notice: 'Application was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /applications/1
  def destroy
    @research_application.destroy
    redirect_to applications_url, notice: 'Application was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @research = Research.where(id: params[:research_id]).includes(:dimensions, :research_applications).first
      @research_application = @research.applications.where(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def research_application_params
      params[:research_application].permit!
    end
end
