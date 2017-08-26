class KeywordsController < ApplicationController
  before_action :set_keyword, only: %i[edit update destroy]
  before_action :set_project

  def index
    @q = Keyword.where(project_id: params[:project_id]).ransack(params[:q])
    @keywords = @q.result
    @keyword = Keyword.new
  end

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.project = @project
    respond_to do |format|
      if @keyword.save
        Log.new(operation: "#{current_user.full_name} ha creado la definicion '#{@keyword.key}'",
                project_name: @project.name, user_name: current_user.short_name).save!
        format.html { redirect_to project_keywords_path, notice: 'Definicion creada con éxito' }
      else
        format.html { redirect_to project_keywords_path, alert: 'ERROR: La definición no ha sido creada' }
      end
    end
  end

  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        Log.new(operation: "#{current_user.full_name} ha actualizado la definicion de '#{@keyword.key}'",
                project_name: @project.name, user_name: current_user.short_name).save!
        format.html { redirect_to project_keywords_path, notice: 'Definicion actualizada con éxito' }
      else
        format.html { redirect_to project_keywords_path, alert: 'ERROR: La definición no se ha actualizado' }
      end
    end
  end

  def destroy
    Log.new(operation: "#{current_user.full_name} ha eliminado la definicion de '#{@keyword.key}'",
            project_name: @project.name, user_name: current_user.short_name).save!
    @keyword.destroy
    respond_to do |format|
      format.html { redirect_to project_keywords_path, notice: 'Definicion borrada con éxito' }
    end
  end

  private

  def set_keyword
    @keyword = Keyword.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def keyword_params
    params.require(:keyword).permit(:key, :definition)
  end
end
