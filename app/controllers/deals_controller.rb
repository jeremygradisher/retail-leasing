class DealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  # GET /deals
  # GET /deals.json
  def index
    #@deals = Deal.all
    if current_user
      if current_user.is_admin?
        @deals = Deal.all
      else
        @deals = Deal.where(project_id: current_user.projects)
      end
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    #@project = @deal.project_id
    @project = Project.find(@deal.project_id)
    @dealimages = @deal.dealimages.all
    
    @areas_deal = AreasDeal.new
    @otherareas = @project.areas.all - @deal.areas
    @otherareasordered = @otherareas.sort_by(&:suite_number)
    
    @schedule = @deal.schedule
  end

  # GET /deals/new
  def new
    @deal = Deal.new
    @project = Project.find(params[:project_id])
    @dealimage = @deal.dealimages.build
    @dealimages = @deal.dealimages.all
    
    @map_id = @deal.map_id
    @project_id = @deal.project_id

    @leasing_managers = LeasingManager.where(project_id: @project).all
  end

  # GET /deals/1/edit
  def edit
    @project = Project.find(@deal.project_id)
    @dealimage = @deal.dealimages.build
    @dealimages = @deal.dealimages.all
    @map_id = @deal.map_id
    @project_id = @deal.project_id
    @leasing_managers = LeasingManager.where(project_id: @project).all
    
    @workletter = @deal.workletter
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)
    @project = Project.find(@deal.project_id)
    @project_id = @deal.project_id
    @dealimages = @deal.dealimages.all

    respond_to do |format|
      if @deal.save
        #(@project.users.uniq - [current_user]).each do |user|
        (@project.users.uniq + User.where(is_admin: true)).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "created", notifiable: @deal)
        end 
        
        if params.has_key?(:dealimages)
           params[:dealimages]['dealimage'].each do |a|
              @dealimage = @deal.dealimages.create!(:dealimage => a)
           end
        end
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    @project = Project.find(@deal.project_id)

    respond_to do |format|
      if @deal.update(deal_params)
        #(@project.users.uniq - [current_user]).each do |user|
        (@project.users.uniq + User.where(is_admin: true)).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "edited", notifiable: @deal)
        end 
        
        if params.has_key?(:dealimages)
           params[:dealimages]['dealimage'].each do |a|
              @dealimage = @deal.dealimages.create!(:dealimage => a)
           end
        end
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @project = Project.find(@deal.project_id)
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deal_params
      params.require(:deal).permit(:deal_name, :gross_area, :net_rentable_area, :lease_status, :map_id, :project_id, :merchandising_status, :turn_over_condition, :lease_execution, :welcome_package, :base_building_cds, :kick_off_call, :landlord_work_sent, :signage_received, :signage_sent, :signage_notes, :permit_submitted, :permit_received, :permit_notes, :check_in, :premises_acceptance, :construction_start, :lay_out_rough_in, :fit_out_finishes, :fixtures, :final_inspections, :merchandising, :open_for_business, :punchlist_request, :punchlist_inspection, :punchlist_complete, :certificate_of_occupancy, :as_builts_received, :final_plans_received, :final_plans_reviewed, :final_plans_notes, :cad_release_form, :close_out_letter, :final_lien_waver, :construction_cost_summary, :sprinkler_shop_drawings, :sprinkler_work_order, :sprinkler_check, :air_balance_report, :deposit_release_approved, :deposit_released, :ta_ti_release_approved, :ta_ti_released, :final_construction_cost, :certificate_of_insurance, :w9, :utility_cost, :tenant_cost, :close_out_notes, :final_plans_status, :signage_status, :signage_reviewed, :storefront_plans_received, :storefront_plans_reviewed, :storefront_plans_status, :storefront_notes, :expiration, :date_of_possession, :fit_out_duration, :abatement, :taxes, :base_rent, :total_base_rent, :percentage_of_rent, :ti_allowance, :ti_cost, :ll_work, :ll_work_cost, :cam, :cam_cost, :comm_inside, :comm_outside, :taxes_cost, :insurance, :insurance_cost, :marketing, :marketing_cost, :trash, :trash_cost, :other, :other_cost, :break_point, :fee_sqft_total, :fee_cost_total, :net_rentable_area, :go_marketing, :go_marketing_cost, :fit_out, :fit_out_cost, :status_notes, :leasing_manager, :budget_rate, :fit_out_duration_if, :tenant_contact, :budget_ti, :base_building_cost, :cash_on_cash, :budget_variance, :increase, :action_required, :owner_approval, :priority, :term_notes, :merchandising_status, :tenant_documents, :landlord_work, :archive, :tenant_description, :key_contacts, :architect, :general_contractor, :other_contacts, :deal_term, dealimages_attributes: [:id, :deal_id, :dealimage])
    end
end
