class WorkletterTemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workletter_template, only: [:show, :edit, :update, :destroy]

  # GET /workletter_templates
  # GET /workletter_templates.json
  def index
    @workletter_templates = WorkletterTemplate.all
  end

  # GET /workletter_templates/1
  # GET /workletter_templates/1.json
  def show
    @project = Project.find(@workletter_template.project_id)
  end

  # GET /workletter_templates/new
  def new
    @workletter_template = WorkletterTemplate.new
    @project_id = params[:project_id]
    #I need this project_id
    @project = Project.find(params[:project_id])
    
    @workletter_templates = @project.workletter_templates.all
  end

  # GET /workletter_templates/1/edit
  def edit
    @project_id = @workletter_template.project_id
    @project = Project.find(@workletter_template.project_id)
    
    @workletter_templates = @project.workletter_templates.all
  end

  # POST /workletter_templates
  # POST /workletter_templates.json
  def create
    @workletter_template = WorkletterTemplate.new(workletter_template_params)

    respond_to do |format|
      if @workletter_template.save
        format.html { redirect_to @workletter_template, notice: 'Workletter template was successfully created.' }
        format.json { render :show, status: :created, location: @workletter_template }
      else
        format.html { render :new }
        format.json { render json: @workletter_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workletter_templates/1
  # PATCH/PUT /workletter_templates/1.json
  def update
    respond_to do |format|
      if @workletter_template.update(workletter_template_params)
        format.html { redirect_to @workletter_template, notice: 'Workletter template was successfully updated.' }
        format.json { render :show, status: :ok, location: @workletter_template }
      else
        format.html { render :edit }
        format.json { render json: @workletter_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workletter_templates/1
  # DELETE /workletter_templates/1.json
  def destroy
    @workletter_template.destroy
    respond_to do |format|
      format.html { redirect_to workletter_templates_url, notice: 'Workletter template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workletter_template
      @workletter_template = WorkletterTemplate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workletter_template_params
      params.require(:workletter_template).permit(:template_name, :project_id, :slab, :slab_description, :slab_typical, :studs, :studs_description, :studs_typical, :drywall, :drywall_description, :drywall_typical, :insulation, :insulation_description, :insulation_typical, :service_door, :service_door_description, :service_door_typical, :storefront, :storefront_description, :storefront_typical, :supply, :supply_description, :supply_typical, :exhaust, :exhaust_description, :exhaust_typical, :unit, :unit_description, :unit_typical, :line_set_pathways, :line_set_pathways_description, :line_set_pathways_typical, :ems, :ems_description, :ems_typical, :voltage, :voltage_description, :voltage_typical, :amperage, :amperage_description, :amperage_typical, :conduit_size, :conduit_size_description, :conduit_size_typical, :electrical, :electrical_description, :electrical_typical, :electrical_meter, :electrical_meter_description, :electrical_meter_typical, :telephone, :telephone_description, :telephone_typical, :sanitary, :sanitary_description, :sanitary_typical, :sanitary_vent, :sanitary_vent_description, :sanitary_vent_typical, :grease, :grease_description, :grease_typical, :water, :water_description, :water_typical, :gas, :gas_description, :gas_typical, :sprinkler_stub, :sprinkler_stub_description, :sprinkler_stub_typical, :sprinkler_grid, :sprinkler_grid_description, :sprinkler_grid_typical, :fire_alarm, :fire_alarm_description, :fire_alarm_typical, :structure, :structure_description, :structure_typical, :demolition, :demolition_description, :demolition_typical, :other, :other_description, :other_typical)
    end
end
