class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
    
    @deal = Deal.find(params[:deal_id])
    @deal_id = @deal.id
    @project_id = @deal.project_id
    @map_id = @deal.map_id
  end

  # GET /schedules/1/edit
  def edit
    @deal = Deal.find(@schedule.deal)
    @deal_id = @deal.id
    @project_id = @deal.project_id
    @map_id = @deal.map_id
    
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @project = Project.find(@schedule.project_id)

    respond_to do |format|
      if @schedule.save
        #(@project.users.uniq - [current_user]).each do |user|
        (@project.users.uniq + User.where(is_admin: true)).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "created", notifiable: @schedule)
        end
        
        format.html { redirect_to @schedule.deal, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    @project = Project.find(@schedule.project_id)
    
    respond_to do |format|
      if @schedule.update(schedule_params)
        #(@project.users.uniq - [current_user]).each do |user|
        (@project.users.uniq + User.where(is_admin: true)).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "edited", notifiable: @schedule)
        end
        
        format.html { redirect_to @schedule.deal, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:project_id, :map_id, :area_id, :deal_id, :lease_execution_date, :final_plans_received_date, :final_plans_reviewed_date, :permit_submitted_date, :permit_received_date, :premises_acceptance_date, :construction_completion_date, :open_for_business_date, :total_days, :design_duration, :ll_review_duration, :permit_submittal_duration, :permit_reviewed_duration, :mobilization_duration, :tenant_fit_out_duration, :merchandising_duration)
    end
end
