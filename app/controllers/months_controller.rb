class MonthsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_month, only: [:show, :edit, :update, :destroy]

  # GET /months
  # GET /months.json
  def index
    @months = Month.all.order('created_at DESC').page(params[:page]).per_page(ENV["MONTHLY_ITEMS"].to_i)
  end

  # GET /months/1
  # GET /months/1.json
  def show
  end

  # GET /months/new
  def new
    @month = Month.new
  end

  # GET /months/1/edit
  def edit
  end

  # PUT /months/1/complete/
  def complete
    @month = Month.find(params[:id])
    @month.toggle!(:completed)
    @month.completed_by = current_user.login

    respond_to do |format|
      if @month.save
        format.html { redirect_to :back, notice: 'Item successfully Completed.' }
        format.json { render action: 'show', status: :created, location: @month }
      else
        format.html {render action: 'new' }
        format.json { render json: @month.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /months
  # POST /months.json
  def create
    @month = Month.new(month_params)

    respond_to do |format|
      if @month.save
        format.html { redirect_to @month, notice: 'Month was successfully created.' }
        format.json { render action: 'show', status: :created, location: @month }
      else
        format.html { render action: 'new' }
        format.json { render json: @month.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /months/1
  # PATCH/PUT /months/1.json
  def update
    respond_to do |format|
      if @month.update(month_params)
        format.html { redirect_to :back, notice: 'Month was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /months/1
  # DELETE /months/1.json
  def destroy
    @month.destroy
    respond_to do |format|
      format.html { redirect_to months_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_month
      @month = Month.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def month_params
      params.require(:month).permit(:title, :completed_by, :completed)
    end
end
