class AreasDealsController < ApplicationController
  before_action :set_areas_deal, only: [:show, :edit, :update, :destroy]

  # GET /areas_deals
  # GET /areas_deals.json
  def index
    @areas_deals = AreasDeal.all
  end

  # GET /areas_deals/1
  # GET /areas_deals/1.json
  def show
  end

  # GET /areas_deals/new
  def new
    @areas_deal = AreasDeal.new
    @project = Project.find(params[:project_id])
  end

  # GET /areas_deals/1/edit
  def edit
    @project = Project.find(@areas_deal.project_id)
  end

  # POST /areas_deals
  # POST /areas_deals.json
  def create
    @areas_deal = AreasDeal.new(areas_deal_params)
    #this was throwing an error on heroku:
    @project = Project.find(@areas_deal.project_id)

    respond_to do |format|
      if @areas_deal.save
        format.html { redirect_to @areas_deal, notice: 'Areas deal was successfully created.' }
        format.json { render :show, status: :created, location: @areas_deal }
      else
        format.html { render :new }
        format.json { render json: @areas_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas_deals/1
  # PATCH/PUT /areas_deals/1.json
  def update
    @project = Project.find(@areas_deal.project_id)
    respond_to do |format|
      if @areas_deal.update(areas_deal_params)
        format.html { redirect_to @areas_deal, notice: 'Areas deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @areas_deal }
      else
        format.html { render :edit }
        format.json { render json: @areas_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas_deals/1
  # DELETE /areas_deals/1.json
  def destroy
    @areas_deal.destroy
    respond_to do |format|
      format.html { redirect_to areas_deals_url, notice: 'Areas deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_areas_deal
      @areas_deal = AreasDeal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def areas_deal_params
      params.require(:areas_deal).permit(:area_id, :deal_id, :project_id)
    end
end
