class BiannualsController < ApplicationController
  before_action :set_biannual, only: [:show, :edit, :update, :destroy]

  # GET /biannuals
  # GET /biannuals.json
  def index
    @biannuals = Biannual.all.order('created_at DESC').page(params[:page]).per_page(8)
  end

  # GET /biannuals/1
  # GET /biannuals/1.json
  def show
  end

  # GET /biannuals/new
  def new
    @biannual = Biannual.new
  end

  # GET /biannuals/1/edit
  def edit
  end

  # PUT /biannuals/1/complete
  def complete
    @biannual = Biannual.find(params[:id])
    @biannual.toggle!(:completed)
    @biannual.completed_by = current_user.login

    respond_to do |format|
      if @biannual.save
        format.html { redirect_to :back, notice: 'Item successfully completed.' }
        format.json { render action: 'show', status: :created, location: @biannual }
      else
        format.html { render action: 'new' }
        format.json { render json: @biannual.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /biannuals
  # POST /biannuals.json
  def create
    @biannual = Biannual.new(biannual_params)

    respond_to do |format|
      if @biannual.save
        format.html { redirect_to @biannual, notice: 'Biannual was successfully created.' }
        format.json { render action: 'show', status: :created, location: @biannual }
      else
        format.html { render action: 'new' }
        format.json { render json: @biannual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /biannuals/1
  # PATCH/PUT /biannuals/1.json
  def update
    respond_to do |format|
      if @biannual.update(biannual_params)
        format.html { redirect_to :back, notice: 'Item successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @biannual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /biannuals/1
  # DELETE /biannuals/1.json
  def destroy
    @biannual.destroy
    respond_to do |format|
      format.html { redirect_to biannuals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biannual
      @biannual = Biannual.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biannual_params
      params.require(:biannual).permit(:title, :completed_by, :completed)
    end
end
