class GlosariosController < ApplicationController
  before_action :set_glosario, only: [:show, :edit, :update, :destroy]

  # GET /glosarios
  # GET /glosarios.json
  def index
    @glosarios = Glosario.all
  end

  # GET /glosarios/1
  # GET /glosarios/1.json
  def show
  end

  # GET /glosarios/new
  def new
    @glosario = Glosario.new
  end

  # GET /glosarios/1/edit
  def edit
  end

  # POST /glosarios
  # POST /glosarios.json
  def create
    @glosario = Glosario.new(glosario_params)

    respond_to do |format|
      if @glosario.save
        format.html { redirect_to @glosario, notice: 'Glosario was successfully created.' }
        format.json { render :show, status: :created, location: @glosario }
      else
        format.html { render :new }
        format.json { render json: @glosario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /glosarios/1
  # PATCH/PUT /glosarios/1.json
  def update
    respond_to do |format|
      if @glosario.update(glosario_params)
        format.html { redirect_to @glosario, notice: 'Glosario was successfully updated.' }
        format.json { render :show, status: :ok, location: @glosario }
      else
        format.html { render :edit }
        format.json { render json: @glosario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /glosarios/1
  # DELETE /glosarios/1.json
  def destroy
    @glosario.destroy
    respond_to do |format|
      format.html { redirect_to glosarios_url, notice: 'Glosario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_glosario
      @glosario = Glosario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def glosario_params
      params.require(:glosario).permit(:key, :definition)
    end
end
