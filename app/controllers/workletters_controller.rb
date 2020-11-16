class WorklettersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workletter, only: [:show, :edit, :update, :destroy]

  # GET /workletters
  # GET /workletters.json
  def index
    @workletters = Workletter.all
  end

  # GET /workletters/1
  # GET /workletters/1.json
  def show
    @area = @workletter.area_id
    @project = Project.find(@workletter.project_id)
  end

  # GET /workletters/new
  def new
    @workletter = Workletter.new
    
    @area = Area.find(params[:area_id])
    @area_id = @area.id
    @map_id = @area.map_id
    @project_id = @area.project_id
    @name = @area.suite_number
    #@map = Map.find(params[:map_id])
    
    #this needs a change:
    #@deal = @area.deals.first

    @deal = @area.deals.first
    
    
    @project = Project.find(@area.project_id)
    @workletter_templates = @project.workletter_templates.all
  end

  # GET /workletters/1/edit
  def edit
    @area = Area.find(@workletter.area_id)
    @project = Project.find(@workletter.project_id)
    
    @deal = @area.deals.first

    @project_id = @area.project_id
    @map_id = @area.map_id
    @area_id = @area.id
    @name = @area.suite_number
    
    @workletter_templates = @project.workletter_templates.all
  end

  # POST /workletters
  # POST /workletters.json
  def create
    @workletter = Workletter.new(workletter_params)
    @project = Project.find(@workletter.project_id)

    respond_to do |format|
      if @workletter.save
        format.html { redirect_to area_path(@workletter.area_id), notice: 'Workletter was successfully created.' }
        format.json { render :show, status: :created, location: @workletter }
      else
        format.html { render :new }
        format.json { render json: @workletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workletters/1
  # PATCH/PUT /workletters/1.json
  def update
    @project = Project.find(@workletter.project_id)
    
    respond_to do |format|
      if @workletter.update(workletter_params)
        format.html { redirect_to area_path(@workletter.area_id), notice: 'Workletter was successfully updated.' }
        format.json { render :show, status: :ok, location: @workletter }
      else
        format.html { render :edit }
        format.json { render json: @workletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workletters/1
  # DELETE /workletters/1.json
  def destroy
    @workletter.destroy
    respond_to do |format|
      format.html { redirect_to workletters_url, notice: 'Workletter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workletter
      @workletter = Workletter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workletter_params
      params.require(:workletter).permit(:name, :project_id, :map_id, :area_id, :ll_count_total, :slab, :studs, :drywall, :insulation, :service_door, :storefront, :supply, :exhaust, :unit, :line_set_pathways, :ems, :voltage, :amperage, :conduit_size, :electrical_meter, :tele_conduit_size, :sanitary, :sanitary_vent, :grease, :water, :gas, :sprinkler_stub, :sprinkler_grid, :fire_alarm, :slab_description, :studs_description, :drywall_description, :storefront_description, :servicedoor_description, :untis_description, :supplyduct_description, :exhaustduct_description, :linesetpathway_description, :emergency_description, :voltage_description, :amperage_description, :conduitsize_description, :panels_description, :meter_description, :telephone_description, :sanitary_description, :sanitaryvent_description, :grease_description, :water_description, :gas_description, :sprinklerstub_description, :sprinklergrid_description, :firealarm_description, :insulation_description, :slab_complete, :slab_typical, :slab_date, :studs_typical, :drywall_typical, :insulation_typical, :service_door_typical, :storefront_typical, :supply_duct_typical, :exhaust_duct_typical, :unit_typical, :line_set_pathways_typical, :ems_typical, :voltage_typical, :amperage_typical, :conduit_size_typical, :electrical_meter_typical, :telephone_typical, :sanitary_typical, :sanitary_vent_typical, :grease_typical, :water_typical, :gas_typical, :sprinkler_stub_typical, :sprinkler_grid_typical, :fire_alarm_typical, :studs_complete, :drywall_complete, :insulation_complete, :service_door_complete, :storefront_complete, :supply_duct_complete, :exhaust_duct_complete, :unit_complete, :line_set_pathways_complete, :ems_complete, :voltage_complete, :amperage_complete, :conduit_size_complete, :electrical_meter_complete, :telephone_complete, :sanitary_complete, :sanitary_vent_complete, :grease_complete, :water_complete, :gas_complete, :sprinkler_stub_complete, :sprinkler_grid_complete, :fire_alarm_complete, :studs_date, :drywall_date, :insulation_date, :service_door_date, :storefront_date, :supply_date, :exhaust_date, :unit_date, :line_set_pathways_date, :ems_date, :voltage_date, :amperage_date, :conduit_size_date, :electrical_meter_date, :tele_conduit_size_date, :sanitary_date, :grease_date, :water_date, :sprinkler_stub_date, :sprinkler_grid_date, :fire_alarm_date, :gas_date, :sanitary_vent_date, :electrical, :electrical_description, :electrical_typical, :electrical_responsibility, :electrical_complete, :electrical_date, :ll_work, :ll_work_cost, :slab_cost, :studs_cost, :drywall_cost, :insulation_cost, :service_door_cost, :storefront_cost, :supply_cost, :exhaust_cost, :unit_cost, :ems_cost, :voltage_cost, :amperage_cost, :conduit_size_cost, :electrical_cost, :electrical_meter_cost, :telephone_cost, :sanitary_cost, :sanitary_vent_cost, :grease_cost, :water_cost, :gas_cost, :sprinkler_stub_cost, :sprinkler_grid_cost, :fire_alarm_cost, :line_set_pathways_cost, :structure, :structure_description, :structure_typical, :structure_complete, :structure_date, :structure_cost, :demolition, :demolition_description, :demolition_typical, :demolition_complete, :demolition_date, :demolition_cost, :other, :other_description, :other_typical, :other_complete, :other_date, :other_cost, :structure_sqft, :structure_unit, :slab_sqft, :slab_unit, :studs_sqft, :studs_unit, :drywall_sqft, :drywall_unit, :insulation_sqft, :insulation_unit, :service_door_sqft, :service_door_unit, :storefront_sqft, :storefront_unit, :hvac_unit_sqft, :hvac_unit_unit, :supply_duct_sqft, :supply_duct_unit, :exhaust_sqft, :exhaust_unit, :line_set_pathways_sqft, :line_set_pathways_unit, :ems_sqft, :ems_unit, :electrical_sqft, :electrical_unit, :voltage_sqft, :voltage_unit, :amperage_sqft, :amperage_unit, :conduit_size_sqft, :conduit_size_unit, :electrical_meter_sqft, :electrical_meter_unit, :telephone_sqft, :telephone_unit, :sanitary_sqft, :sanitary_unit, :sanitary_vent_sqft, :sanitary_vent_unit, :grease_sqft, :grease_unit, :water_sqft, :water_unit, :gas_sqft, :gas_unit, :sprinkler_stub_sqft, :sprinkler_stub_unit, :sprinkler_grid_sqft, :sprinkler_grid_unit, :fire_alarm_sqft, :fire_alarm_unit, :demolition_sqft, :demolition_unit, :other_sqft, :other_unit)
    end
end
