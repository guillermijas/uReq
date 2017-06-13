class RequirementsController < ApplicationController
  before_action :set_requirement, only: %i[show edit update destroy]
  before_action :set_project
  before_action :authenticate_user!


  def index
    @requirements = Requirement.where(project_id: params[:project_id])
  end

  def show; end

  def edit; end

  def new
    @requirement = Requirement.new
  end

  def create
    @requirement = Requirement.new(requirement_params)
    @requirement.project = @project
    @requirement.user = current_user
    @requirement.id_in_project = @requirement.next_id(@project.id)
    respond_to do |format|
      if @requirement.save
        Log.new(operation: "#{current_user.full_name} ha creado el requisito '#{@requirement.id_string}'",
                project_id: @project.id, user_id: current_user.id, requirement_id: @requirement.id).save!
        format.html { redirect_to project_requirements_path(@project), notice: 'Requisito creado' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @requirement.user = current_user
      if @requirement.update(requirement_params)
        Log.new(operation: "#{current_user.full_name} ha actualizado el requisito '#{@requirement.id_string}'",
                project_id: @project.id, user_id: current_user.id, requirement_id: @requirement.id).save!
        format.html { redirect_to project_requirements_path(@project), notice: 'Requisito actualizado' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @requirement.destroy
    respond_to do |format|
      Log.new(operation: "#{current_user.full_name} ha borrado el requisito '#{@requirement.id_string}'",
              project_id: @project.id, user_id: current_user.id, requirement_id: @requirement.id).save!
      format.html { redirect_to project_requirements_path(@project), notice: 'Requisito eliminado' }
    end
  end

  def select
    @requirements = Requirement.where(project_id: params[:project_id])
    @requirement = Requirement.find(params[:id])
    @comments = @requirement.id_string
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def new_modal
    @requirement = Requirement.new
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def set_requirement
    @requirement = Requirement.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def requirement_params
    params.require(:requirement).permit(:suffix, :description,
                                        :status, :end_date,
                                        :category, :level)
  end
end
