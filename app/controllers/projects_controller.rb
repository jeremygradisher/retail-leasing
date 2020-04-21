class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :users, :add_user]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
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
      #@dealsofprimary = Deal.where(map_id: @map.id)
    end
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
    @project_users = @project.users.all
    @other_users = User.where(is_admin: false) - (@project_users + [current_user])
    @all_users = User.all
  end

  def add_user
    @project_user = UserProject.new(user_id: params[:user_id], project_id: @project.id)
    respond_to do |format|
      if @project_user.save
        format.html { redirect_to users_tenant_project_url(id: @project.id,
        tenant_id: @project.tenant_id),
        notice: 'User was successfully added to project' }
      else
        format.html { redirect_to users_tenant_project_url(id: @project.id,
        tenant_id: @project.tenant_id),
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
      params.require(:project).permit(:name, :user_id, :user_id, icons_attributes: [:id, :project_id, :icon])
    end
end
