class YearsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_year, only: [:show, :edit, :update, :destroy]

  # GET /years
  # GET /years.json
  def index
    @years = Year.all.order('created_at DESC').page(params[:page]).per_page(9)
  end

  # GET /years/1
  # GET /years/1.json
  def show
  end

  # GET /years/new
  def new
    @year = Year.new
  end

  # GET /years/1/edit
  def edit
  end

  # PUT /years/1/complete/
  def complete
    @year = Year.find(params[:id])
    @year.toggle!(:completed)
    @year.completed_by = current_user.login

    respond_to do |format|
      if @year.save
        format.html { redirect_to :back, notice: 'Item successfully Completed.' }
        format.json { render action: 'show', status: :created, location: @year }
      else
        format.html { render action: 'new' }
        format.json { render json: @year.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /years
  # POST /years.json
  def create
    @year = Year.new(year_params)

    respond_to do |format|
      if @year.save
        format.html { redirect_to @year, notice: 'Year was successfully created.' }
        format.json { render action: 'show', status: :created, location: @year }
      else
        format.html { render action: 'new' }
        format.json { render json: @year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /years/1
  # PATCH/PUT /years/1.json
  def update
    respond_to do |format|
      if @year.update(year_params)
        format.html { redirect_to :back, notice: 'Item successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /years/1
  # DELETE /years/1.json
  def destroy
    @year.destroy
    respond_to do |format|
      format.html { redirect_to years_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_year
      @year = Year.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def year_params
      params.require(:year).permit(:title, :completed_by, :completed)
    end
end
