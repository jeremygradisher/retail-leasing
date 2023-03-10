class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy, 
        :users, :add_user, :spaces, :deals, :charts, :map, :retail, :merch]

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
    #really need to go through these and see what I can cut down
    @maps = @project.maps.all
    @map = @project.maps.first
    
    if @project.maps.present?
      @maptitle = @map.name
      @image = @map.images.first
      #@areasofprimary = @map.areas.all
      @mapareas = @map.areas.sort_by(&:suite_number)
      @areas = @map.areas.all

      #example:
      #@q = Person.ransack(params[:q])
      #@people = @q.result(distinct: true)
      #original:
      #@areasforlist = @map.areas.sort_by(&:suite_number)
      #with ransack
      @areasquery = @areas.ransack(params[:q])
      #@areasforlist = @areasquery.result(distinct: true)
      @areasforlist = @areasquery.result(distinct: true)

      #@deals = Deal.where(map_id: @map.id).sort_by(&:deal_name)
      @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
      @areas_deals = AreasDeal.where(project_id: params[:id]).all
    end
    @tenants = Area.where(project_id: params[:id]).size



    @areas_deal = AreasDeal.new
    @primary_deal = PrimaryDeal.new
    
    #with ransack
    @deals = @project.deals.where.not(archive: true).all
    #@dealsquery = @deals.ransack(params[:q])
    #@dealsforlist = @dealsquery.result(distinct: true)
    
    #@deals = @project.deals.where.not(archive: true).all
    @dealsforpopup = @project.deals.where.not(archive: true).all.sort_by(&:deal_name)
    @dealsforarchivedlist = @project.deals.where(archive: true).all.sort_by(&:deal_name)
    @dealscount = @deals.size
    
    #@dealsforlist = @project.deals.where.not(archive: true).all.sort_by(&:deal_name)
    @dealsquery = @project.deals.where.not(archive: true).ransack(params[:q])
    @dealsforlist = @dealsquery.result(distinct: true)

    
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
        #create notification
        #(@project.users.uniq - [current_user]).each do |user|
        (@project.users.uniq + User.where(is_admin: true)).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "created", notifiable: @project)
        end
        
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
        #create notification
        (@project.users.uniq + User.where(is_admin: true)).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "edited", notifiable: @project)
        end
        
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
    #This is to ensure that only admins can destroy
    raise "You must be an admin to delete a Project" unless current_user.is_admin? == true
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
  
  def spaces
    @maps = @project.maps.all
    @map = @project.maps.first
    @projectname = @project.name
    
    @areas = @map.areas.all
    #@areasforlist = @map.areas.sort_by(&:suite_number)
    @areasquery = @areas.ransack(params[:q])
    @areasforlist = @areasquery.result.includes(:project, :deals)
  end
  
  def deals
    @deals = @project.deals.where.not(archive: true).all
    @projectname = @project.name

    #@dealsforlist = @project.deals.where.not(archive: true).all.sort_by(&:deal_name)
    @dealsquery = @project.deals.where.not(archive: true).ransack(params[:q])
    @dealsforlist = @dealsquery.result(distinct: true)
  end
  
  def charts
    @deals = @project.deals.where.not(archive: true).all
    @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
    @netrentablearea = @deals.where.not(archive: true).pluck(:net_rentable_area)
    
    @maps = @project.maps.all
    @map = @project.maps.first
    @areas = @map.areas.all
    
    @tenants = Area.where(project_id: params[:id]).size
    @dealscount = @deals.where.not(archive: true).size
  end
  
  def map
    @maps = @project.maps.all
    @map = @project.maps.first
    
    if @project.maps.present?
      @maptitle = @map.name
      @image = @map.images.first
      @mapareas = @map.areas.sort_by(&:suite_number)
      @areas = @map.areas.all

      #@areasforlist = @map.areas.sort_by(&:suite_number)

      #@deals = Deal.where(map_id: @map.id)
      #@areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
      #@areas_deals = AreasDeal.where(project_id: params[:id]).all
    end
    
    @areas_deal = AreasDeal.new
    @primary_deal = PrimaryDeal.new
    
    @deals = @project.deals.where.not(archive: true).all
    @dealsforpopup = @project.deals.where.not(archive: true).all.sort_by(&:deal_name)
    @dealsforarchivedlist = @project.deals.where(archive: true).all.sort_by(&:deal_name)
    @dealscount = @deals.where.not(archive: true).size
  end
  
  def retail
    @maps = @project.maps.all
    @map = @project.maps.first
    
    if @project.maps.present?
      @maptitle = @map.name
      @image = @map.images.first
      #@areasofprimary = @map.areas.all
      @mapareas = @map.areas.sort_by(&:suite_number)
      @areas = @map.areas.all
      
      #need to change this up for Ransack
      #example:
      #@q = Person.ransack(params[:q])
      #@people = @q.result(distinct: true)
      #original:
      @areasforlist = @map.areas.sort_by(&:suite_number)
      #with ransack
      #@areasquery = @map.areas.ransack(params[:q])
      #@areasforlist = @areasquery.result(distinct: true)

      @deals = Deal.where(map_id: @map.id)
      @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
      @areas_deals = AreasDeal.where(project_id: params[:id]).all
    end
    @tenants = Area.where(project_id: params[:id]).size
    
    @areas_deal = AreasDeal.new
    @primary_deal = PrimaryDeal.new
    
    @deals = @project.deals.where.not(archive: true).all
    @dealsforpopup = @project.deals.where.not(archive: true).all.sort_by(&:deal_name)
    @dealsforarchivedlist = @project.deals.where(archive: true).all.sort_by(&:deal_name)
    @dealscount = @deals.where.not(archive: true).size
    
    @dealsforlist = @project.deals.where.not(archive: true).all.sort_by(&:lease_status)
    #@dealsquery = @project.deals.where.not(archive: true).ransack(params[:q])
    #@dealsforlist = @dealsquery.result(distinct: true)

    
    @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
    @netrentablearea = @deals.where.not(archive: true).pluck(:net_rentable_area)
    
    #Going to need something like this:
    @q = @project.users.where(is_admin: false).ransack(params[:q])
    @project_users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5)
    
    @workletter_templates = WorkletterTemplate.where(project_id: params[:id])
    
    #For Leasing Managers Index on projects#show:
    @leasing_managers = LeasingManager.where(project_id: params[:id]).all

  end
  
  def merch
    @maps = @project.maps.all
    @map = @project.maps.first
    
    if @project.maps.present?
      @maptitle = @map.name
      @image = @map.images.first
      #@areasofprimary = @map.areas.all
      @mapareas = @map.areas.sort_by(&:suite_number)
      @areas = @map.areas.all
      
      #need to change this up for Ransack
      #example:
      #@q = Person.ransack(params[:q])
      #@people = @q.result(distinct: true)
      #original:
      @areasforlist = @map.areas.sort_by(&:suite_number)
      #with ransack
      #@areasquery = @map.areas.ransack(params[:q])
      #@areasforlist = @areasquery.result(distinct: true)

      @deals = Deal.where(map_id: @map.id)
      @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
      @areas_deals = AreasDeal.where(project_id: params[:id]).all
    end
    @tenants = Area.where(project_id: params[:id]).size
    
    @areas_deal = AreasDeal.new
    @primary_deal = PrimaryDeal.new
    
    @deals = @project.deals.where.not(archive: true).all
    @dealsforpopup = @project.deals.where.not(archive: true).all.sort_by(&:deal_name)
    @dealsforarchivedlist = @project.deals.where(archive: true).all.sort_by(&:deal_name)
    @dealscount = @deals.where.not(archive: true).size
    
    @dealsforlist = @project.deals.where.not(archive: true).all.sort_by(&:lease_status)
    #@dealsquery = @project.deals.where.not(archive: true).ransack(params[:q])
    #@dealsforlist = @dealsquery.result(distinct: true)

    
    @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
    @netrentablearea = @deals.where.not(archive: true).pluck(:net_rentable_area)
    
    #Going to need something like this:
    @q = @project.users.where(is_admin: false).ransack(params[:q])
    @project_users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5)
    
    @workletter_templates = WorkletterTemplate.where(project_id: params[:id])
    
    #For Leasing Managers Index on projects#show:
    @leasing_managers = LeasingManager.where(project_id: params[:id]).all

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
  
  def testreport
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
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-lease-status-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/reports/testreport',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/reports/testreport_header.pdf.erb'
            }
          },
          footer: {
            html: {
              template: '/reports/testreport_footer.pdf.erb'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'testreport.pdf.erb', layout: 'pdf_layout' }
      format.xlsx {
        #response.headers['Content-Disposition'] = 'attachment; filename="tenant_status.xlsx"'
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-lease-status-report-#{Date.today}.xlsx"
      }
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
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-lease-status-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/leasestatusreport',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/leasestatusreport_header'
            }
          },
          footer: {
            html: {
              template: '/projects/leasestatusreport_footer'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'leasestatusreport', layout: 'pdf_layout' }
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
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-lease-deal-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/leasedealreport',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/leasedealreport_header'
            }
          },
          footer: {
            html: {
              template: '/projects/leasedealreport_footer'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'leasedealreport', layout: 'pdf_layout' }
      format.xlsx {
        #response.headers['Content-Disposition'] = 'attachment; filename="tenant_status.xlsx"'
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-lease-deal-report-#{Date.today}.xlsx"
      }
    end
  end

  #this is the Close Out Report
  def closeoutreport
    @project = Project.find(params[:id])
    @ransack = Area.where(project_id: params[:id]).ransack(params[:q])
    @areas = @ransack.result(distinct: true)
    
    #@areas_with = @areas.where(self.deals.count > 0)
    
    @table_object = generate_area_object(@areas)

    @stats = generate_area_statistics

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-close-out-report-#{Date.today}",
          orientation: 'landscape',
          template: '/projects/closeoutreport',
          layout: 'pdf_layout',
          locals: { stats: @stats },
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/closeoutreport_header'
            }
          },
          footer: {
            html: {
              template: '/projects/closeoutreport_footer'
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
        render 'closeoutreport', layout: 'pdf_layout', locals: { stats: @stats } 
      }
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-close-out-report-#{Date.today}.xlsx"
      }
    end
  end

  def tenantstatusreport
    @project = Project.find(params[:id])
    @ransack = Area.where(project_id: params[:id]).ransack(params[:q])
    @areas = @ransack.result(distinct: true)
    
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
          template: '/projects/tenantstatusreport',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/tenantstatusreport_header'
            }
          },
          footer: {
            html: {
              template: '/projects/tenantstatusreport_footer'
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
        render 'tenantstatusreport', layout: 'pdf_layout', locals: { stats: @stats } 
      }
      format.xlsx {
          response.headers['Content-Disposition'] = "attachment; filename=#{@project.name.parameterize}-tenant-status-report-#{Date.today}.xlsx"
      }
    end
  end
  
  #for deal_directory_report
  def dealdirectoryreport
    @areas = Area.where(project_id: params[:id]).all
    @deals = Deal.where(project_id: params[:id]).where.not(archive: true).all
    @project = Project.find(params[:id])
    
    #@tenants = @areas.count
    #@dealscount = @deals.count
    @areasquarefootage = @areas.pluck(:area_sqft)
    @netrentablearea = @deals.pluck(:net_rentable_area)
    #@dealarea = @deals.pluck(:net_rentable_area)

    # this is areas after being sorted in private method
    @table_object = generate_deal_object(@deals)

    respond_to do |format|
      format.pdf {
        render pdf: "#{@project.name.parameterize}-deal-directory-report-#{Date.today}",
          orientation: 'landscape',
          javascript_delay: 2000,
          template: '/projects/dealdirectoryreport',
          layout: 'pdf_layout',
          page_size: 'A3',
          header: {
            html: {
              template: '/projects/dealdirectoryreport_header'
            }
          },
          footer: {
            html: {
              template: '/projects/dealdirectoryreport_footer'
            }
          },
          margin: {
            bottom: 15,
            top: 25,
            left: 5,
            right: 5
          }
      }
      format.html { render 'dealdirectoryreport', layout: 'pdf_layout' }
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
      if area.deals.count > 0
        array << {
          areastatus: area.status,
          suite_number: area.suite_number,
          lease_status: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.lease_status : area.deals.last.lease_status,
          area_sqft: area.area_sqft,
          deal_name: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.deal_name : area.deals.last.deal_name,
          punchlist_request: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.punchlist_request : area.deals.last.punchlist_request,
          punchlist_inspection: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.punchlist_inspection : area.deals.last.punchlist_inspection,
          punchlist_complete: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.punchlist_complete : area.deals.last.punchlist_complete,
          close_out_letter: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.close_out_letter : area.deals.last.close_out_letter,
          permit_received: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.permit_received : area.deals.last.permit_received,
          certificate_of_insurance: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.certificate_of_insurance : area.deals.last.certificate_of_insurance,
          certificate_of_occupancy: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.certificate_of_occupancy : area.deals.last.certificate_of_occupancy,
          final_lien_waver: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.final_lien_waver : area.deals.last.final_lien_waver,
          w9: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.punchlist_complete : area.deals.last.punchlist_complete,
          final_construction_cost: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.final_construction_cost : area.deals.last.final_construction_cost,
          as_builts_received: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.as_builts_received : area.deals.last.as_builts_received,
          sprinkler_shop_drawings: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.sprinkler_shop_drawings : area.deals.last.sprinkler_shop_drawings,
          close_out_notes: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.close_out_notes : area.deals.last.close_out_notes,
          construction_cost_summary: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.construction_cost_summary : area.deals.last.construction_cost_summary,
          sprinkler_work_order: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.sprinkler_work_order : area.deals.last.sprinkler_work_order,
          air_balance_report: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.air_balance_report : area.deals.last.air_balance_report,
          sprinkler_check: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.sprinkler_check : area.deals.last.sprinkler_check,
          tenant_cost: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.tenant_cost : area.deals.last.tenant_cost,
          utility_cost: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.utility_cost : area.deals.last.utility_cost,
          deposit_release_approved: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.deposit_release_approved : area.deals.last.deposit_release_approved,
          deposit_released: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.deposit_released : area.deals.last.deposit_released,
          ta_ti_release_approved: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.ta_ti_release_approved : area.deals.last.ta_ti_release_approved,
          ta_ti_released: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.ta_ti_released : area.deals.last.ta_ti_released,
          
        }
      else
        array << {
          areastatus: area.status,
          suite_number: area.suite_number,
          lease_status: 'Available',
          area_sqft: area.area_sqft,
          deal_name: 'No deal',
          punchlist_request: '',
          punchlist_inspection: '',
          punchlist_complete: '',
          close_out_letter: '',
          permit_received: '',
          certificate_of_insurance: '',
          certificate_of_occupancy: '',
          final_lien_waver: '',
          w9: '',
          construction_cost_summary: '',
          final_construction_cost: '',
          as_builts_received: '',
          sprinkler_shop_drawings: '',
          close_out_notes: ''
        }
      end
    end
    ordering = ['Leased', 'At Lease', 'LOI', 'Prospect', 'Available', '']
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
        suite_number: deal.areas.blank? ? 'No Area' : deal.areas.last.suite_number,
        area_sqft: deal.gross_area,
        deal_term: deal.deal_term,
        merchandising_status: deal.merchandising_status,
        budget_rate: deal.budget_rate,
        base_rent: deal.base_rent,
        increase: deal.increase,
        #ll_work: Workletter.where(id: deal.area.workletter).exists? ? Workletter.find(deal.area.workletter).ll_work : 'N/A',
        ll_work: 0,
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
        tenant_contact: deal.tenant_contact,
        close_out_notes: deal.close_out_notes
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
          suite_number: area.suite_number,
          name: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.deal_name : area.deals.last.deal_name,
          area_sqft: area.area_sqft,
          lease_status: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.lease_status : area.deals.last.lease_status,
          lease_execution: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.lease_execution : area.deals.last.lease_execution,
          turn_over_condition: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.turn_over_condition : area.deals.last.turn_over_condition,
          fit_out_duration: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.fit_out_duration : area.deals.last.fit_out_duration,
          date_of_possession: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.date_of_possession : area.deals.last.date_of_possession,
          landlord_work_sent: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.landlord_work_sent : area.deals.last.landlord_work_sent,
          tenant_approval: area.tenant_approval, 
          welcome_package: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.welcome_package : area.deals.last.welcome_package,
          base_building_cds: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.base_building_cds : area.deals.last.base_building_cds,
          kick_off_call: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.kick_off_call : area.deals.last.kick_off_call,
          cad_release_form: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.cad_release_form : area.deals.last.cad_release_form,
          final_plans_received: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.final_plans_received : area.deals.last.final_plans_received,
          final_plans_reviewed: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.final_plans_reviewed : area.deals.last.final_plans_reviewed,
          final_plans_status: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.final_plans_status : area.deals.last.final_plans_status,
          permit_submitted: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.permit_submitted : area.deals.last.permit_submitted,
          permit_received: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.permit_received : area.deals.last.permit_received,
          signage_received: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.signage_received : area.deals.last.signage_received,
          signage_reviewed: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.signage_reviewed : area.deals.last.signage_reviewed,
          signage_status: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.signage_status : area.deals.last.signage_status,
          signage_install_date: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.signage_install_date : area.deals.last.signage_install_date,
          check_in: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.check_in : area.deals.last.check_in,
          premises_acceptance: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.premises_acceptance : area.deals.last.premises_acceptance,
          construction_start: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.construction_start : area.deals.last.construction_start,
          lay_out_rough_in: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.lay_out_rough_in : area.deals.last.lay_out_rough_in,
          fit_out_finishes: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.fit_out_finishes : area.deals.last.fit_out_finishes,
          fixtures: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.fixtures : area.deals.last.fixtures,
          final_inspections: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.final_inspections : area.deals.last.final_inspections,
          merchandising: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.merchandising : area.deals.last.merchandising,
          open_for_business: area.primary_deals.ids.count > 0 ? area.primary_deals.last.deal.open_for_business : area.deals.last.open_for_business,
          area_comments: area.area_comments
        }
      else
        array << {
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
          lease_status: area.deals.last.exists? ? area.deals.last.lease_status : available,
          lease_execution: area.lease_execution, 
          turn_over_condition: area.turn_over_condition, 
          fit_out_duration: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).fit_out_duration : area.deals.last.fit_out_duration,
          date_of_possession: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).date_of_possession : area.deals.last.date_of_possession,
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
        lease_status: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).lease_status : area.deals.last.lease_status,
        area_primary_deal: area.primary_deal.blank? ? area.deals.last.id : area.primary_deal.to_i,
        primary_lease_status: Deal.where(id: area.primary_deal.to_i).exists? ? Deal.find(area.primary_deal.to_i).lease_status : area.deals.last.lease_status,
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
      #total_construction_cost: @areas.deals.last.map{ |m| m.final_construction_cost}.compact.inject(:+),
      total_construction_cost: 1000,

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
