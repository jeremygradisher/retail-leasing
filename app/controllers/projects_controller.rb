class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :users, :add_user]

  # GET /projects
  # GET /projects.json
  def index
    #@projects = Project.all
    if current_user
      if current_user.is_admin?
        @projects = Project.all
      else
        @projects = current_user.projects
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @maps = @project.maps.all
    @map = @project.maps.first
    
    if @project.maps.present?
      @maptitle = @map.name
      @image = @map.images.first
      #@areasofprimary = @map.areas.all
      @mapareas = @map.areas.all
      @areas = @map.areas.all
      @areasforlist = @map.areas.sort_by(&:suite_number)
      @deals = Deal.where(map_id: @map.id)
      @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
      @areas_deals = AreasDeal.where(project_id: params[:id]).all
    end
    @tenants = Area.where(project_id: params[:id]).size
    
    @areas_deal = AreasDeal.new
    @deals = @project.deals.all
    @dealsforlist = @project.deals.all.sort_by(&:lease_status)
    @dealscount = @deals.size
    
    @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
    @netrentablearea = @deals.pluck(:net_rentable_area)
    
    #Going to need something like this:
    @q = @project.users.where(is_admin: false).ransack(params[:q])
    @project_users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5)
    
    @workletter_templates = WorkletterTemplate.where(project_id: params[:id])
    
    #For Leasing Managers Index on projects#show:
    @leasing_managers = LeasingManager.where(project_id: params[:id]).all
  end

  # GET /projects/new
  def new
    @project = Project.new
    @icon = @project.icons.build
    @icons = @project.icons.all
  end

  # GET /projects/1/edit
  def edit
    @icon = @project.icons.build
    @icons = @project.icons.all
    #@maps = @project.maps.all
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        if params.has_key?(:icons)
           params[:icons]['icon'].each do |a|
              @icon = @project.icons.create!(:icon => a)
           end
        end
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        if params.has_key?(:icons)
           params[:icons]['icon'].each do |a|
              @icon = @project.icons.create!(:icon => a)
           end
        end
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def users
    #@project_users = @project.users.all
    @query = @project.users.where.not(is_admin: true).ransack(params[:q])
    @project_users = @query.result(distinct: true)
    
    #@other_users = User.all - (@project_users + [current_user])
    @q = User.where.not(is_admin: true).ransack(params[:q])
    @other_users = @q.result(distinct: true) - (@project_users + [current_user])
    
    @all_users = User.all
  end

  def add_user
    @project_user = UserProject.new(user_id: params[:user_id], project_id: @project.id)
    respond_to do |format|
      if @project_user.save
        format.html { redirect_to users_project_url(id: @project.id),
        notice: 'User was successfully added to project' }
      else
        format.html { redirect_to users_project_url(id: @project.id),
        error: 'User was not added to project' }
      end
    end
  end
  
  def leasestatusreport
    @areas = Area.where(project_id: params[:id]).all
    @deals = Deal.where(project_id: params[:id]).where.not(archive: true).all
    @project = Project.find(params[:id])
    
    @tenants = @areas.count
    @dealscount = @deals.count
    @areasquarefootage = @areas.pluck(:area_sqft)
    @netrentablearea = @deals.pluck(:net_rentable_area)
    @gla = @areas.pluck(:area_sqft)
    @potential = @deals.pluck(:net_rentable_area)

    # this is areas after being sorted in private method
    #@table_object = generate_area_object(@areas)
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-lease-status-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/leasestatusreport.pdf.erb',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/leasestatusreport_header.pdf.erb'
            }
          },
          footer: {
            html: {
              template: '/projects/leasestatusreport_footer.pdf.erb'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'leasestatusreport.pdf.erb', layout: 'pdf_layout' }
      format.xlsx {
        #response.headers['Content-Disposition'] = 'attachment; filename="tenant_status.xlsx"'
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-lease-status-report-#{Date.today}.xlsx"
      }
    end
  end
  
  def leasedealreport
    @areas = Area.where(project_id: params[:id]).all
    @deals = Deal.where(project_id: params[:id]).where.not(archive: true).all
    @project = Project.find(params[:id])
    
    @tenants = @areas.count
    @dealscount = @deals.count
    @areasquarefootage = @areas.pluck(:area_sqft)
    @netrentablearea = @deals.pluck(:net_rentable_area)
    @dealarea = @deals.pluck(:net_rentable_area)

    # this is areas after being sorted in private method
    #@table_object = generate_area_object(@areas)
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-lease-deal-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/leasedealreport.pdf.erb',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/leasedealreport_header.pdf.erb'
            }
          },
          footer: {
            html: {
              template: '/projects/leasedealreport_footer.pdf.erb'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'leasedealreport.pdf.erb', layout: 'pdf_layout' }
      format.xlsx {
        #response.headers['Content-Disposition'] = 'attachment; filename="tenant_status.xlsx"'
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-lease-deal-report-#{Date.today}.xlsx"
      }
    end
  end

  #this is the Close Out Report
  def closeoutreport
    @project = Project.find(params[:id])
    @search = Area.where(project_id: params[:id]).search(params[:q])
    @areas = @search.result(distinct: true)

    @stats = generate_area_statistics

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-close-out-report-#{Date.today}",
          orientation: 'landscape',
          template: '/projects/closeoutreport.pdf.erb',
          layout: 'pdf_layout',
          locals: { stats: @stats },
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/closeoutreport_header.pdf.erb'
            }
          },
          footer: {
            html: {
              template: '/projects/closeoutreport_footer.pdf.erb'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { 
        render 'closeoutreport.pdf.erb', layout: 'pdf_layout', locals: { stats: @stats } 
      }
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-close-out-report-#{Date.today}.xlsx"
      }
    end
  end

  def tenantstatusreport
    @project = Project.find(params[:id])
    @search = Area.where(project_id: params[:id]).search(params[:q])
    @areas = @search.result(distinct: true)
    
    @tenants = Area.where(project_id: params[:id]).count
    @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
    #@netrentablearea = Deal.where(project_id: params[:id]).pluck(:net_rentable_area)

    # this is areas after being sorted in private method
    @areasxlsx = generate_tsr_object(@areas)
    
    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-tenant-status-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/tenantstatusreport.pdf.erb',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/tenantstatusreport_header.pdf.erb'
            }
          },
          footer: {
            html: {
              template: '/projects/tenantstatusreport_footer.pdf.erb'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { 
        render 'tenantstatusreport.pdf.erb', layout: 'pdf_layout', locals: { stats: @stats } 
      }
      format.xlsx {
          response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-tenant-status-report-#{Date.today}.xlsx"
      }
    end
  end
  
  #for deal_directory_report
  def dealdirectoryreport
    #@areas = Area.where(project_id: params[:id]).all
    @deals = Deal.where(project_id: params[:id]).where.not(archive: true).all
    @project = Project.find(params[:id])
    
    #@tenants = @areas.count
    #@dealscount = @deals.count
    #@areasquarefootage = @areas.pluck(:area_sqft)
    #@netrentablearea = @deals.pluck(:net_rentable_area)
    #@dealarea = @deals.pluck(:net_rentable_area)

    # this is areas after being sorted in private method
    #@table_object = generate_area_object(@areas)
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-deal-directory-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/dealdirectoryreport.pdf.erb',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/dealdirectoryreport_header.pdf.erb'
            }
          },
          footer: {
            html: {
              template: '/projects/dealdirectoryreport_footer.pdf.erb'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'dealdirectoryreport.pdf.erb', layout: 'pdf_layout' }
      format.xlsx {
        #response.headers['Content-Disposition'] = 'attachment; filename="tenant_status.xlsx"'
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-deal-directory-report-#{Date.today}.xlsx"
      }
    end
  end
  
  def adhocreport
    @project = Project.find(params[:id])
    @maps = @project.maps.all
    @icon = @project.icons.first
    @icons = @project.icons.all
    @areas = Area.where(project_id: params[:id]).all
    #@deals = Deal.where(project_id: params[:id]).all
    @deals = Deal.where(project_id: params[:id]).where.not(archive: true).all
    @adhoc_object = generate_adhoc_object(@areas)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :user_id, :address, :city, :state, :zip, :project_type, :description, :owner, :owner_address, :owner_city, :owner_state, :owner_zip, :owner_contact, :owner_email, :owner_phone, :project_square_feet, :status, icons_attributes: [:id, :project_id, :icon])
    end
    
    
  def generate_area_object(areas)
    array = []
    areas.each do |area|
      array << {
        lease_status: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).lease_status : area.deals.first.lease_status,
        name: area.name.blank? ? 'Untitled Area' : area.name,
        suite_number: area.suite_number,
        area_sqft: area.area_sqft,
        deal_term: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).deal_term : area.deals.first.deal_term,
        merchandising_status: area.merchandising_status,
        budget_rate: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).budget_rate : area.deals.first.budget_rate,
        base_rent: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).base_rent : area.deals.first.base_rent,
        increase: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).increase : area.deals.first.increase,
        
        ll_work: Workletter.where(id: area.workletter).exists? ? Workletter.find(area.workletter).ll_work : 'N/A',

        total_base_rent: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).total_base_rent : area.deals.first.total_base_rent,
        ti_allowance: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).ti_allowance : area.deals.first.ti_allowance,
        ti_cost: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).ti_cost : area.deals.first.ti_cost,
        cash_on_cash: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).cash_on_cash : area.deals.first.cash_on_cash,
        close_out_letter: area.close_out_letter.present? ? Date.strptime(area.close_out_letter,"%m/%d/%Y").strftime("%m/%d/%y") : '',
        budget_variance: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).budget_variance : area.deals.first.budget_variance,
        status_notes: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).status_notes : area.deals.first.status_notes,
        leasing_manager: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).leasing_manager : area.deals.first.leasing_manager,
        action_required: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).action_required : area.deals.first.action_required
      }
    end
    ordering = ['Leased', 'At Lease', 'LOI', 'Prospect', 'Available']
    sorted_array = []
    ordering.each do |order|
      selected_array = array.select{|m| m[:lease_status] == order}
      sorted_array << selected_array.sort_by{ |obj| obj[:suite_number] }
    end
    sorted_array.flatten!
  end
  
  def generate_deal_object(deals)
    array = []
    deals.each do |deal|
      array << {
        lease_status: deal.lease_status,
        owner_approval: deal.owner_approval,
        name: deal.deal_name.blank? ? 'Untitled Deal' : deal.deal_name,
        suite_number: deal.areas.blank? ? 'No Area' : deal.areas.first.suite_number,
        area_sqft: deal.gross_area,
        deal_term: deal.deal_term,
        merchandising_status: deal.merchandising_status,
        budget_rate: deal.budget_rate,
        base_rent: deal.base_rent,
        increase: deal.increase,
        #ll_work: Workletter.where(id: deal.area.workletter).exists? ? Workletter.find(deal.area.workletter).ll_work : 'N/A',
        ll_work: 'TBD',
        total_base_rent: deal.total_base_rent,
        ti_allowance: deal.ti_allowance,
        ti_cost: deal.ti_cost,
        cash_on_cash: deal.cash_on_cash,
        #close_out_letter: deal.area.close_out_letter.present? ? Date.strptime(deal.area.close_out_letter,"%m/%d/%Y").strftime("%m/%d/%y") : '',
        close_out_letter: 'TBD',
        budget_variance: deal.budget_variance,
        status_notes: deal.status_notes,
        leasing_manager: deal.leasing_manager.blank? ? '' : LeasingManager.find(deal.leasing_manager.to_i).name,
        action_required: deal.action_required,
        priority: deal.priority,
        architect: deal.architect,
        general_contractor: deal.general_contractor,
        other_contacts: deal.other_contacts,
        tenant_contact: deal.tenant_contact
      }
    end
    ordering = ['Leased', 'At Lease', 'LOI', 'Prospect', 'Available']
    sorted_array = []
    ordering.each do |order|
      selected_array = array.select{|m| m[:lease_status] == order}
      sorted_array << selected_array.sort_by{ |obj| obj[:suite_number] }
    end
    sorted_array.flatten!
  end
  
  def generate_tsr_object(areas)
    array = []
    areas.each do |area|
      if area.deals.count > 0
        array << {
          #opening_status: area.opening_status,
          suite_number: area.suite_number,
          name: area.suite_number,
          area_sqft: area.area_sqft, 
          lease_status: area.deals.first.lease_status,
          #lease_execution: area.lease_execution, 
          lease_execution: area.deals.first.lease_execution,
          #turn_over_condition: area.turn_over_condition, 
          turn_over_condition: area.deals.first.turn_over_condition,
          #fit_out_duration: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).fit_out_duration : area.deals.first.fit_out_duration,
          fit_out_duration: area.deals.first.fit_out_duration,
          #date_of_possession: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).date_of_possession : area.deals.first.date_of_possession,
          date_of_possession: area.deals.first.date_of_possession,
          #landlord_work_sent: area.landlord_work_sent, 
          landlord_work_sent: area.deals.first.landlord_work_sent,
          tenant_approval: area.tenant_approval, 
          #welcome_package: area.welcome_package, 
          welcome_package: area.deals.first.welcome_package,
          #base_building_cds: area.base_building_cds, 
          base_building_cds: area.deals.first.base_building_cds,
          #kick_off_call: area.kick_off_call, 
          kick_off_call: area.deals.first.kick_off_call,
          #cad_release_form: area.cad_release_form, 
          cad_release_form: area.deals.first.cad_release_form,
          final_plans_received: area.deals.first.final_plans_received,
          final_plans_reviewed: area.deals.first.final_plans_reviewed,
          final_plans_status: area.deals.first.final_plans_status,
          permit_submitted: area.deals.first.permit_submitted,
          permit_received: area.deals.first.permit_received,
          signage_received: area.deals.first.signage_received,
          signage_reviewed: area.deals.first.signage_reviewed,
          signage_status: area.deals.first.signage_status,
          check_in: area.deals.first.check_in,
          premises_acceptance: area.deals.first.premises_acceptance,
          construction_start: area.deals.first.construction_start,
          lay_out_rough_in: area.deals.first.lay_out_rough_in,
          fit_out_finishes: area.deals.first.fit_out_finishes,
          fixtures: area.deals.first.fixtures,
          final_inspections: area.deals.first.final_inspections,
          merchandising: area.deals.first.merchandising,
          open_for_business: area.deals.first.open_for_business,
          area_comments: area.area_comments
        }
      else
        array << {
          #opening_status: area.opening_status,
          suite_number: area.suite_number,
          name: area.suite_number,
          area_sqft: area.area_sqft, 
          lease_status: 'no deal for area',
          lease_execution: 'no deal for area',
          turn_over_condition: 'no deal for area', 
          fit_out_duration: 'no deal for area',
          date_of_possession: 'no deal for area',
          landlord_work_sent: 'no deal for area',
          tenant_approval: 'no deal for area',
          welcome_package: 'no deal for area',
          base_building_cds: 'no deal for area',
          kick_off_call: 'no deal for area',
          cad_release_form: 'no deal for area',
          final_plans_received: 'no deal for area',
          final_plans_reviewed: 'no deal for area',
          final_plans_status: 'no deal for area',
          permit_submitted: 'no deal for area',
          permit_received: 'no deal for area',
          signage_received: 'no deal for area',
          signage_reviewed: 'no deal for area',
          signage_status: 'no deal for area',
          check_in: 'no deal for area',
          premises_acceptance: 'no deal for area',
          construction_start: 'no deal for area',
          lay_out_rough_in: 'no deal for area',
          fit_out_finishes: 'no deal for area',
          fixtures: 'no deal for area',
          final_inspections: 'no deal for area',
          merchandising: 'no deal for area',
          open_for_business: 'no deal for area',
          area_comments: area.area_comments,
        }
      end
    end
    ordering = ['Leased', 'At Lease', 'LOI', 'Prospect', 'Available']
    sorted_array = []
    ordering.each do |order|
      selected_array = array.select{|m| m[:lease_status] == order}
      sorted_array << selected_array.sort_by{ |obj| obj[:suite_number] }
    end
    sorted_array.flatten!
  end
  
  #deal_contact_report
  def generate_deal_contact_object(deals)
    array = []
    areas.each do |area|
        array << {
          opening_status: area.opening_status,
          suite_number: area.suite_number,
          name: area.name.blank? ? 'Untitled Area' : area.name,
          area_sqft: area.area_sqft, 
          lease_status: area.deals.first.exists? ? area.deals.first.lease_status : available,
          lease_execution: area.lease_execution, 
          turn_over_condition: area.turn_over_condition, 
          fit_out_duration: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).fit_out_duration : area.deals.first.fit_out_duration,
          date_of_possession: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).date_of_possession : area.deals.first.date_of_possession,
          landlord_work_sent: area.landlord_work_sent, 
          tenant_approval: area.tenant_approval, 
          welcome_package: area.welcome_package, 
          base_building_cds: area.base_building_cds, 
          kick_off_call: area.kick_off_call, 
          cad_release_form: area.cad_release_form, 
          final_plans_received: area.final_plans_received, 
          final_plans_reviewed: area.final_plans_reviewed, 
          final_plans_status: area.final_plans_status, 
          permit_submitted: area.permit_submitted, 
          permit_received: area.permit_received, 
          signage_received: area.signage_received, 
          signage_reviewed: area.signage_reviewed, 
          signage_status: area.signage_status, 
          check_in: area.check_in, 
          premises_acceptance: area.premises_acceptance, 
          construction_start: area.construction_start, 
          lay_out_rough_in: area.lay_out_rough_in, 
          fit_out_finishes: area.fit_out_finishes, 
          fixtures: area.fixtures, 
          final_inspections: area.final_inspections, 
          merchandising: area.merchandising, 
          open_for_business: area.open_for_business, 
          area_comments: area.area_comments,
        }
    end
    ordering = ['Leased', 'At Lease', 'LOI', 'Prospect', 'Available']
    sorted_array = []
    ordering.each do |order|
      selected_array = array.select{|m| m[:lease_status] == order}
      sorted_array << selected_array.sort_by{ |obj| obj[:suite_number] }
    end
    sorted_array.flatten!
  end
  
  def generate_adhoc_object(areas)
    array = []
    areas.each do |area|
      array << {
        lease_status: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).lease_status : area.deals.first.lease_status,
        area_primary_deal: area.primary_deal.blank? ? area.deals.first.id : area.primary_deal.to_i,
        primary_lease_status: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).lease_status : area.deals.first.lease_status,
        name: area.name.blank? ? 'Untitled Area' : area.name,
        suite_number: area.suite_number,
        area_sqft: area.area_sqft,
        merchandising_status: area.merchandising_status,
        area_status: area.area_status,
        opening_status: area.opening_status
        }
    end
    ordering = ['Leased', 'At Lease', 'LOI', 'Prospect', 'Available']
    sorted_array = []
    ordering.each do |order|
      selected_array = array.select{|m| m[:lease_status] == order}
      sorted_array << selected_array.sort_by{ |obj| obj[:suite_number] }
    end
    sorted_array.flatten!
  end

  def generate_area_statistics
    stats = {
      total_square_feet: @areas.map{ |m| m.area_sqft}.compact.inject(:+),
      #total_construction_cost: @areas.map{ |m| m.final_construction_cost}.compact.inject(:+),
      total_construction_cost: 189987000,
      not_started: {
        total: @areas.select{|m| m.status == 'not-started'}.count
      },
      completed: {
        total: @areas.select{|m| m.status == 'completed'}.count
      },
      begun: {
        total: @areas.select{|m| m.status == 'begun'}.count
      },
      in_progress: {
        total: @areas.select{|m| m.status == 'in-progress'}.count
      }
    }
    stats[:total_cost_per_sq_feet] = stats[:total_construction_cost] / stats[:total_square_feet]
    area_count = @areas.count.to_f
    stats[:not_started][:percentage] = (stats[:not_started][:total].to_f / area_count).round(2)  * 100
    stats[:completed][:percentage] = (stats[:completed][:total].to_f / area_count).round(2)  * 100
    stats[:begun][:percentage] = (stats[:begun][:total].to_f / area_count).round(2)  * 100
    stats[:in_progress][:percentage] = (stats[:in_progress][:total].to_f / area_count).round(2)  * 100
    stats
  end
    
    
end
