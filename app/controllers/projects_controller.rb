class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :show_modal, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end


  def show_modal
    respond_to do |format|
      format.js {render layout: false}
    end
  end



  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.users.push(current_user)
    @project.users.push(User.where(role: 'admin').where.not(id: current_user))

    respond_to do |format|
      if @project.save
        @project.user_projects.each do |usr_pr|
          usr_pr.owner = true
          usr_pr.save
        end
        Log.new(operation: "#{current_user.full_name} ha creado el proyecto '#{@project.name}'", project_id: @project.id, user_id: current_user.id).save!
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :client, :end_date, :status, :picture)
  end
end
