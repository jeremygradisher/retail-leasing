class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    #@areas = Area.all
    if current_user
      if current_user.is_admin?
        @areas = Area.all
      else
        @areas = Area.where(project_id: current_user.projects)
      end
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @map = Map.find(@area.map_id)
    @map_id = params[:map_id]
    @image = @map.images.first
    @areas = @map.areas.all
    @project = Project.find(@area.project_id)
    
    #@deal = @area.deals.first
    #@deals = @area.deals.all
    @areas_deal = AreasDeal.new
    @otherdeals = @project.deals.all - @area.deals
  end

  # GET /areas/new
  def new
    @area = Area.new
    @map = Map.find(params[:map_id])
    @map_id = params[:map_id]
    @image = @map.images.first
    @areas = @map.areas.all
    @project = Project.find(params[:project_id])
  end

  # GET /areas/1/edit
  def edit
    @map = Map.find(@area.map_id)
    @image = @map.images.first
    @areas = @map.areas.all
    @project = Project.find(@map.project_id)
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(:suite_number, :map_id, :project_id, :status, :coords, :map_id, :area_sqft, :address, :landlord_plan_notes, :tenant_approval, :area_comments, :system_type, :quantity, :unit_brand, :unit_voltage, :pipe_system, :voltage, :main_amperage, :transformer, :sub_panel_amperage, :conduit_size, :electric_meter_number, :electric_meter_install_date, :electric_meter_transfer_date, :restrooms, :sanitary_size, :sanitary_type, :vent_size, :water_size, :water_meter_number, :sub_meter_number, :sub_meter_install_date, :sub_meter_transfer_date, :gas_size, :gas_meter, :gas_meter_install_date, :gas_meter_transfer_date, :grease_size, :tonnage, :vav_size, :conduit_quantity, :telephone_conduit_size, :telephone_conduit_quantity, :pipe_system_note, :area_budget_rate, :service_door_quantity)
    end
end
