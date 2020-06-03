class DealsController < ApplicationController
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
  end

  # GET /deals/new
  def new
    @deal = Deal.new
    @project = Project.find(params[:project_id])
    @dealimage = @deal.dealimages.build
    @dealimages = @deal.dealimages.all
  end

  # GET /deals/1/edit
  def edit
    @project = Project.find(@deal.project_id)
    @dealimage = @deal.dealimages.build
    @dealimages = @deal.dealimages.all
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)

    respond_to do |format|
      if @deal.save
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
    respond_to do |format|
      if @deal.update(deal_params)
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
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
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
      params.require(:deal).permit(:deal_name, :gross_area, :net_rentable_area, :lease_status, :map_id, :project_id, dealimages_attributes: [:id, :deal_id, :dealimage])
    end
end
