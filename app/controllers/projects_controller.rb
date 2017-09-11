class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy show_modal archive export_csv]
  before_action :authenticate_user!

  def index
    usr_pr = UserProject.where(user: current_user).pluck(:project_id)
    @projects = Project.where.not(status: 'archived').where(id: usr_pr, deleted: false)
  end

  def show
    redirect_to project_requirements_path(@project)
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params.except(:user_ids))
    @project.users.push(current_user) # meter el usuario que lo crea es propietario
    @project.users.push(User.admins) # los admin tambien
    @project.users.push(User.find(params[:project][:user_ids].reject(&:blank?))) if params[:project][:user_ids].present?
    respond_to do |format|
      if @project.save
        @project.user_projects.each do |usr_pr|
          usr_pr.owner = (usr_pr.user == current_user || usr_pr.user.role == 'admin' ? true : false)
          usr_pr.save
        end
        Log.create!(operation: 'Crear proyecto', project: @project, user: current_user)
        format.html { redirect_to projects_path, notice: 'El proyecto se ha creado con éxito' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params.except(:user_ids))
        @project.users.push(User.find(params[:project][:user_ids].reject(&:blank?))) if params[:project][:user_ids].present?
        @project.save
        Log.create!(operation: 'Actualizar proyecto', project: @project, user: current_user)
        format.html { redirect_to projects_path, notice: 'El proyecto se ha actualizado corretamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.update(deleted: true)
    Log.create!(operation: 'Eliminar proyecto', project: @project, user: current_user)
    redirect_to projects_url, notice: 'El proyecto se ha eliminado con éxito'
  end

  def show_modal
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def index_archived
    usr_pr = UserProject.where(user: current_user).pluck(:project_id)
    @projects = Project.where(status: 'archived').where(id: usr_pr, deleted: false)
    respond_to do |format|
      format.html { render 'index' }
    end
  end

  def archive
    respond_to do |format|
      if @project.update(status: 'archived')
        Log.create!(operation: 'Archivar proyecto', project: @project, user: current_user)
        format.html { redirect_to projects_path, notice: 'El proyecto se ha archivado corretamente.' }
      else
        format.html { redirect_to projects_path, alert: 'El proyecto no se ha podido archivar.' }
      end
    end
  end

  def export_csv
    render csv: Requirement.where(project_id: @project.id), filename: "#{@project.name}_reqs", type: 'text/csv'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :client, :end_date, :status,
                                    :picture, :delete_picture, :trello_board_id,
                                    :trello_list_id, user_ids: [])
  end
end
