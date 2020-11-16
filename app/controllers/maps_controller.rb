class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: [:show, :edit, :update, :destroy]

  # GET /maps
  # GET /maps.json
  def index
    if current_user
      if current_user.is_admin?
        @maps = Map.all
      else
        @maps = Map.where(project_id: current_user.projects)
      end
    end
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
    @images = @map.images.all
    @image = @map.images.first
    @project = Project.find(@map.project_id)
    @mapareas = @map.areas.all
    
    @areas_deal = AreasDeal.new
    @deals = @project.deals.all
  end

  # GET /maps/new
  def new
    @map = Map.new
    @image = @map.images.build
    @images = @map.images.all
    @project = Project.find(params[:project_id])
  end

  # GET /maps/1/edit
  def edit
    @image = @map.images.build
    @images = @map.images.all
    @project = Project.find(@map.project_id)
  end

  # POST /maps
  # POST /maps.json
  def create
    @map = Map.new(map_params)

    respond_to do |format|
      if @map.save
        if params.has_key?(:images)
           params[:images]['image'].each do |a|
              @image = @map.images.create!(:image => a)
           end
        end
        format.html { redirect_to @map, notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    respond_to do |format|
      if @map.update(map_params)
        if params.has_key?(:images)
           params[:images]['image'].each do |a|
              @image = @map.images.create!(:image => a)
           end
        end
        format.html { redirect_to @map, notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: @map }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to maps_url, notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def map_params
      params.require(:map).permit(:name, :user_id, :project_id, images_attributes: [:id, :project_id, :map_id, :image])
    end
end
