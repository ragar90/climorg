class EmployeesController < ApplicationController
  before_action :set_research_and_organization
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  def index
    @employees = @research.employees
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.organization_id = @organization.id
  end

  # POST /employees
  def create
    Employee.transaction do
      if params[:employee_id]
        @employee = Employee.find_not_associated_to_research(@research.id,params[:employee_id])
        if @employee.nil?
          @ok = false
        else
          @employee.access_token = Devise.friendly_token
          @employee.has_evaluated_research = false
          @ok = true
        end
      else
        @employee = Employee.new(employee_params)
      end
      @ok = @ok and @employee.save
      @ok = @ok and Evaluation.create(employee_id: @employee.id, research_id: @research.id)
      raise ActiveRecord::RollBack unless @ok
    end
    if @ok
      redirect_to employees_path, notice: 'Employee was successfully created.'
    else
      render action: 'new'
    end
  end

  def massive_upload
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def set_research_and_organization
      @research = current_organization.researches.where(id: params[:research_id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:name, :email, :access_token, :has_evaluated_research)
    end
end
