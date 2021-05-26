class PrimaryDealsController < ApplicationController
  before_action :set_primary_deal, only: [:show, :edit, :update, :destroy]

  # GET /primary_deals
  # GET /primary_deals.json
  def index
    @primary_deals = PrimaryDeal.all
  end

  # GET /primary_deals/1
  # GET /primary_deals/1.json
  def show
  end

  # GET /primary_deals/new
  def new
    @primary_deal = PrimaryDeal.new
    @project = Project.find(params[:project_id])
  end

  # GET /primary_deals/1/edit
  def edit
    @project = Project.find(@primary_deal.project_id)
  end

  # POST /primary_deals
  # POST /primary_deals.json
  def create
    @primary_deal = PrimaryDeal.new(primary_deal_params)
    
    @project = Project.find(@primary_deal.project_id)

    respond_to do |format|
      if @primary_deal.save
        (@project.users.uniq).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "created", notifiable: @primary_deal)
        end
        
        format.html { redirect_to @project, notice: 'Primary deal was successfully created.' }
        format.json { render :show, status: :created, location: @primary_deal }
      else
        format.html { render :new }
        format.json { render json: @primary_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /primary_deals/1
  # PATCH/PUT /primary_deals/1.json
  def update
    respond_to do |format|
      if @primary_deal.update(primary_deal_params)
        (@project.users.uniq).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "edited", notifiable: @primary_deal)
        end
        
        format.html { redirect_to @primary_deal, notice: 'Primary deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @primary_deal }
      else
        format.html { render :edit }
        format.json { render json: @primary_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /primary_deals/1
  # DELETE /primary_deals/1.json
  def destroy
    @project = Project.find(@primary_deal.project_id)
    @primary_deal.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Primary deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_primary_deal
      @primary_deal = PrimaryDeal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def primary_deal_params
      params.require(:primary_deal).permit(:area_id, :deal_id, :project_id)
    end
end
