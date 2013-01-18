class DemographicTypesController < ApplicationController
  # GET /demographic_types
  # GET /demographic_types.json
  def index
    @demographic_types = DemographicType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demographic_types }
    end
  end

  # GET /demographic_types/1
  # GET /demographic_types/1.json
  def show
    @demographic_type = DemographicType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @demographic_type }
    end
  end

  # GET /demographic_types/new
  # GET /demographic_types/new.json
  def new
    @demographic_type = DemographicType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @demographic_type }
    end
  end

  # GET /demographic_types/1/edit
  def edit
    @demographic_type = DemographicType.find(params[:id])
  end

  # POST /demographic_types
  # POST /demographic_types.json
  def create
    @demographic_type = DemographicType.new(params[:demographic_type])

    respond_to do |format|
      if @demographic_type.save
        format.html { redirect_to @demographic_type, notice: 'Demographic type was successfully created.' }
        format.json { render json: @demographic_type, status: :created, location: @demographic_type }
      else
        format.html { render action: "new" }
        format.json { render json: @demographic_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /demographic_types/1
  # PUT /demographic_types/1.json
  def update
    @demographic_type = DemographicType.find(params[:id])

    respond_to do |format|
      if @demographic_type.update_attributes(params[:demographic_type])
        format.html { redirect_to @demographic_type, notice: 'Demographic type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @demographic_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demographic_types/1
  # DELETE /demographic_types/1.json
  def destroy
    @demographic_type = DemographicType.find(params[:id])
    @demographic_type.destroy

    respond_to do |format|
      format.html { redirect_to demographic_types_url }
      format.json { head :no_content }
    end
  end
end
