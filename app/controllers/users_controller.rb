class UsersController < ApplicationController
  
  def new
    @user   = User.new
  end

  def index
    @users = User.all
    
    #new for ransack:
    @q = @users.ransack(params[:q])
    #@other_users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5)
    @all_users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @user = User.find(params[:id])
    @userprojects = @user.project_ids
  end
  
  def edit
    @user = User.find(params[:id])
    @user_avatar = @user.user_avatars.build
    @user_avatars = @user.user_avatars.all
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        if params.has_key?(:user_avatars)
           params[:user_avatars]['avatar'].each do |a|
              @user_avatar = @user.user_avatars.create!(:avatar => a)
           end
        end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :invited_by, :invited_by_id, :project_id)
  end

end