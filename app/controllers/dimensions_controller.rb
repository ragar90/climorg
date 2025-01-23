class DimensionsController < ApplicationController
  # GET /dimensions
  # GET /dimensions.json
  def index
    @dimensions = current_user.dimensions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dimensions }
    end
  end

  # GET /dimensions/1
  # GET /dimensions/1.json
  def show
    @dimension = current_user.dimensions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dimension }
    end
  end

  # GET /dimensions/new
  # GET /dimensions/new.json
  def new
    @dimension = Dimension.new
    @dimension.is_default=true
    respond_to do |format|
      format.html { render :layout=>@layout } # new.html.erb
      format.json { render json: @dimension }
    end
  end

  # GET /dimensions/1/edit
  def edit
    @dimension = current_user.dimensions.find(params[:id])
  end

  # POST /dimensions
  # POST /dimensions.json
  def create
    @dimension = Dimension.new(permited_params(:dimension))
    @dimension.user = current_user
    respond_to do |format|
      if @dimension.save
        json_object = params[:modal]=="true" ?  {:value=>@dimension.id,:display_value=>@dimension.name, :class=>"dimension"} : @dimension
        format.html { redirect_to @dimension, notice: 'Dimension was successfully created.' }
        format.json { render :json=> json_object.to_json, status: :created, location: @dimension }
      else
        format.html { render action: "new",:layout=>@layout  }
        format.json { render :json=> {:errors=>@dimension.errors}.to_json, status: :created }
      end
    end
  end

  # PUT /dimensions/1
  # PUT /dimensions/1.json
  def update
    @dimension = current_user.dimensions.find(params[:id])

    respond_to do |format|
      if @dimension.update_attributes(permited_params(:dimension))
        format.html { redirect_to @dimension, notice: 'Dimension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dimensions/1
  # DELETE /dimensions/1.json
  def destroy
    @dimension = current_user.dimensions.find(params[:id])
    @dimension.is_active = false
    @dimension.save

    respond_to do |format|
      format.html { redirect_to dimensions_url }
      format.json { head :no_content }
    end
  end
end
