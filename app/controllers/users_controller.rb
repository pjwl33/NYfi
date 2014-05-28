class UsersController < ApplicationController

  before_action :authenticate, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
    @show_link = true
    respond_to do |format|
      format.html
      format.json {render json: @users.to_json}
    end
  end

  def show
    @user = User.find params[:id]
    respond_to do |format|
      format.html
      format.json {render json: @user.to_json}
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to @user, notice: "New Account Created!"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
    if current_user == @user || admin?
      render 'edit'
    else
      redirect_to @user, notice: "You do not have access to that account!"
    end
  end

  def update
    @user = User.find params[:id]
    if current_user == @user || admin?
      @user.update user_params
      redirect_to @user, notice: "Account Updated!"
    end
  end

  def destroy
    @user = User.find params[:id]
    if current_user == @user || admin?
      @user.destroy
      redirect_to users_path
    else
      redirect_to users_path, notice: "This Ain't Yo' Account"
    end
  end

  #adding a favorite hotspot to user hotspots list
  def add_hotspot
    User.add_hotspot(params[:user_id], params[:hotspot_id])
    flash[:notice] = "Hotspot Added to #{current_user.name}'s Favorites!"
    redirect_to hotspot_path(params[:hotspot_id])
  end

  #removing a favorite hotspot from user hotspots list
  def remove_hotspot
    if User.remove_hotspot(params[:user_id], params[:hotspot_id])
      flash[:notice] = "Hotspot Removed!"
      redirect_to user_path(params[:user_id])
    else
      flash[:notice] = "That's not your account!"
      redirect_to user_path(params[:user_id])
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :admin
  end

end
