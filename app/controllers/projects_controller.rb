class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy show_modal archive]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    usr_pr = UserProject.where(user: current_user).pluck(:project_id)
    @projects = Project.where.not(status: 'archived').where(id: usr_pr)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    redirect_to project_requirements_path(@project)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.users.push(current_user)
    @project.users.push(User.where(role: 'admin').where.not(id: current_user))
    respond_to do |format|
      if @project.save!
        @project.user_projects.each do |usr_pr|
          usr_pr.owner = true
          usr_pr.save
        end
        Log.new(operation: "#{current_user.full_name} ha creado el proyecto '#{@project.name}'", project_id: @project.id, user_id: current_user.id).save!
        format.html { redirect_to projects_path, notice: 'El proyecto se ha creado con éxito' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        Log.new(operation: "#{current_user.full_name} ha actualizado el proyecto '#{@project.name}'", project_id: @project.id, user_id: current_user.id).save!
        format.html { redirect_to projects_path, notice: 'El proyecto se ha actualizado corretamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    Log.new(operation: "#{current_user.full_name} ha eliminado el proyecto '#{@project.name}'", project_id: @project.id, user_id: current_user.id).save!
    redirect_to projects_url, notice: 'El proyecto se ha eliminado con éxito'
  end

  def show_modal
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def index_archived
    usr_pr = UserProject.where(user: current_user).pluck(:project_id)
    @projects = Project.where(status: 'archived').where(id: usr_pr)
    respond_to do |format|
      format.html { render 'index' }
    end
  end

  def archive
    respond_to do |format|
      if @project.update(status: 'archived')
        Log.new(operation: "#{current_user.full_name} ha archivado el proyecto '#{@project.name}'", project_id: @project.id, user_id: current_user.id).save!
        format.html { redirect_to projects_path, notice: 'El proyecto se ha archivado corretamente.' }
      else
        format.html { redirect_to projects_path, alert: 'El proyecto no se ha podido archivador.' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :client, :end_date, :status,
                                    :picture, :delete_picture, :trello_board_id,
                                    :trello_list_id)
  end
end
