class LeasingManagersController < ApplicationController
  before_action :set_leasing_manager, only: [:show, :edit, :update, :destroy]

  # GET /leasing_managers
  # GET /leasing_managers.json
  def index
    @leasing_managers = LeasingManager.all
  end

  # GET /leasing_managers/1
  # GET /leasing_managers/1.json
  def show
  end

  # GET /leasing_managers/new
  def new
    @leasing_manager = LeasingManager.new

    #@projects = Project.where(id: current_user.project_ids)
    if current_user.is_admin?
      @projects = Project.all
    else
      @projects = Project.where(id: current_user.project_ids)
    end
  end

  # GET /leasing_managers/1/edit
  def edit
  end

  # POST /leasing_managers
  # POST /leasing_managers.json
  def create
    @leasing_manager = LeasingManager.new(leasing_manager_params)
    @projects = Project.where(id: current_user.project_ids)

    respond_to do |format|
      if @leasing_manager.save
        format.html { redirect_to @leasing_manager, notice: 'Leasing manager was successfully created.' }
        format.json { render :show, status: :created, location: @leasing_manager }
      else
        format.html { render :new }
        format.json { render json: @leasing_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leasing_managers/1
  # PATCH/PUT /leasing_managers/1.json
  def update
    @projects = Project.where(id: current_user.project_ids)
    
    respond_to do |format|
      if @leasing_manager.update(leasing_manager_params)
        format.html { redirect_to @leasing_manager, notice: 'Leasing manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @leasing_manager }
      else
        format.html { render :edit }
        format.json { render json: @leasing_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leasing_managers/1
  # DELETE /leasing_managers/1.json
  def destroy
    @leasing_manager.destroy
    respond_to do |format|
      format.html { redirect_to leasing_managers_url, notice: 'Leasing manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leasing_manager
      @leasing_manager = LeasingManager.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leasing_manager_params
      params.require(:leasing_manager).permit(:name, :email, :phone, :project_id)
    end
end
