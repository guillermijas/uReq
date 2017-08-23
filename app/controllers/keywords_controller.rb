class KeywordsController < ApplicationController
  before_action :set_keyword, only: %i[show edit update destroy]
  before_action :set_project

  # GET /keywords
  # GET /keywords.json
  def index
    @q = Keyword.where(project_id: params[:project_id]).ransack(params[:q])
    @keywords = @q.result
    @keyword = Keyword.new
  end

  # GET /keywords/1
  def show; end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit; end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.project = @project
    respond_to do |format|
      if @keyword.save
        format.html { redirect_to project_keywords_path, notice: 'Definicion creada con éxito' }
      else
        format.html { redirect_to project_keywords_path, alert: 'ERROR: La definición no ha sido creada' }
      end
    end
  end

  # PATCH/PUT /keywords/1
  # PATCH/PUT /keywords/1.json
  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
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
