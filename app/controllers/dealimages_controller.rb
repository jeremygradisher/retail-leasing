class DealimagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dealimage, only: [:show, :edit, :update, :destroy]

  # GET /dealimages
  # GET /dealimages.json
  def index
    @dealimages = Dealimage.all
  end

  # GET /dealimages/1
  # GET /dealimages/1.json
  def show
  end

  # GET /dealimages/new
  def new
    @dealimage = Dealimage.new
  end

  # GET /dealimages/1/edit
  def edit
  end

  # POST /dealimages
  # POST /dealimages.json
  def create
    @dealimage = Dealimage.new(dealimage_params)

    respond_to do |format|
      if @dealimage.save
        format.html { redirect_to @dealimage, notice: 'Dealimage was successfully created.' }
        format.json { render :show, status: :created, location: @dealimage }
      else
        format.html { render :new }
        format.json { render json: @dealimage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dealimages/1
  # PATCH/PUT /dealimages/1.json
  def update
    respond_to do |format|
      if @dealimage.update(dealimage_params)
        format.html { redirect_to @dealimage.deal, notice: 'Deal image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dealimages/1
  # DELETE /dealimages/1.json
  def destroy
    @dealimage.destroy
    respond_to do |format|
      format.html { redirect_to @dealimage.deal, notice: 'Deal image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dealimage
      @dealimage = Dealimage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dealimage_params
      params.require(:dealimage).permit(:deal_id, :dealimage, :deal_id)
    end
end
