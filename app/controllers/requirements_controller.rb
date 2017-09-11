class RequirementsController < ApplicationController
  before_action :set_requirement, only: %i[show edit update destroy]
  before_action :set_project
  before_action :authenticate_user!

  def index
    @q = Requirement.where(deleted: false).where(project_id: params[:project_id]).order(:id_in_project).ransack(params[:q])
    @requirements = @q.result
    @requirement = Requirement.new(project: @project)
    redirect_to projects_path unless can? :read, @requirement
  end

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

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
        Log.create(operation: 'Crear requisito', project: @project, user: current_user, requirement: @requirement)
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
        Log.create(operation: 'Actualizar requisito', project: @project, user: current_user, requirement: @requirement)
        format.html { redirect_to project_requirements_path(@project), notice: 'Requisito actualizado' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @requirement.update(deleted: true)
    respond_to do |format|
      Log.create(operation: 'Elminar requisito', project: @project, user: current_user, requirement: @requirement)
      format.html { redirect_to project_requirements_path(@project), notice: 'Requisito eliminado' }
    end
  end

  def select
    @scroll = params[:scroll]
    @requirements = Requirement.where(project_id: params[:project_id], deleted: false).order(:id_in_project)
    @requirement = Requirement.find(params[:id])
    @comments = Comment.where(requirement_id: params[:id], deleted: false)
    @comment = Comment.new
    if params[:task_id].present?
      Task.new(requirement: @requirement, trello_task_id: params[:task_id]).save!
      Log.create!(operation: 'Crear tarea Trello', project_id: @project, user_id: current_user.id, requirement_id: @requirement.id)
    end
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
                                        :category, :level,
                                        :satisfies_id, :task_id)
  end
end
