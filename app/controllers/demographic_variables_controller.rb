class DemographicVariablesController < ApplicationController
  # GET /demographic_variables
  # GET /demographic_variables.json
  def index
    @demographic_variables = DemographicVariable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demographic_variables }
    end
  end

  # GET /demographic_variables/1
  # GET /demographic_variables/1.json
  def show
    @demographic_variable = DemographicVariable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @demographic_variable }
    end
  end

  # GET /demographic_variables/new
  # GET /demographic_variables/new.json
  def new
    @demographic_variable = DemographicVariable.new
    @demographic_variable.is_default=true
    respond_to do |format|
      format.html { render :layout=>@layout }
      format.json { render json: @demographic_variable }
    end
  end

  # GET /demographic_variables/1/edit
  def edit
    @demographic_variable = DemographicVariable.find(params[:id])
  end

  # POST /demographic_variables
  # POST /demographic_variables.json
  def create
    @demographic_variable = DemographicVariable.new(params[:demographic_variable])
    
    respond_to do |format|
      if @demographic_variable.save
        json_object = params[:modal]=="true" ?  {:value=>@demographic_variable.id,:display_value=>@demographic_variable.name, :class=>"demographic_variable"} : @demographic_variable
        format.html { redirect_to @demographic_variable, notice: 'Demographic variable was successfully created.' } 
        format.json { render :json=> json_object.to_json, status: :created, location: @demographic_variable }
      else
        format.html { render action: "new", :layout=>@layout  }
        format.json { render :json=> {:errors=>@demographic_variable.errors}.to_json, status: :created }
      end
    end
  end

  # PUT /demographic_variables/1
  # PUT /demographic_variables/1.json
  def update
    @demographic_variable = DemographicVariable.find(params[:id])

    respond_to do |format|
      if @demographic_variable.update_attributes(params[:demographic_variable])
        format.html { redirect_to @demographic_variable, notice: 'Demographic variable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @demographic_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demographic_variables/1
  # DELETE /demographic_variables/1.json
  def destroy
    @demographic_variable = DemographicVariable.find(params[:id])
    @demographic_variable.destroy

    respond_to do |format|
      format.html { redirect_to demographic_variables_url }
      format.json { head :no_content }
    end
  end
end
