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
      @deals = Deal.where(map_id: @map.id)
      @areasquarefootage = Area.where(project_id: params[:id]).pluck(:area_sqft)
      @areas_deals = AreasDeal.where(project_id: params[:id]).all
    end
    @tenants = Area.where(project_id: params[:id]).size
    
    @areas_deal = AreasDeal.new
    @deals = @project.deals.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :user_id, :address, :city, :state, :zip, :project_type, :description, :owner, :owner_address, :owner_city, :owner_state, :owner_zip, :owner_contact, :owner_email, :owner_phone, :project_square_feet, :status, icons_attributes: [:id, :project_id, :icon])
    end
end
