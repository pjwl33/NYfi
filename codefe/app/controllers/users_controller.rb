class UsersController < ApplicationController

  before_action :authenticate

  def index
    @users = User.all
    @show_link = true
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "New Account Created!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
    if current_user == @user
      render 'edit'
    else
      flash[:notice] = "You do not have access to that account!"
      redirect_to @user
    end
  end

  def update
    @user = User.find params[:id]
    if current_user == @user || admin?
      @user.update user_params
      flash[:notice] = "Account Updated!"
      redirect_to @user
    end
  end

  def destroy
    @user = User.find params[:id]
    if current_user == @user || admin?
      @user.destroy
      redirect_to users_path
    else
      flash[:notice] = "This Ain't Yo' Account"
      redirect_to users_path
    end
  end

  def add_hotspot
    user = User.find params[:user_id]
    hotspot = Hotspot.find params[:hotspot_id]
    user.hotspots << hotspot
    flash[:notice] = "Hotspot Added to #{user.name}'s Favorites!"
    redirect_to hotspot_path(hotspot)
  end

  def remove_hotspot
    user = User.find params[:user_id]
    hotspot = Hotspot.find params[:hotspot_id]
    user.hotspots.destroy(hotspot.id)
    flash[:notice] = "Hotspot Removed!"
    redirect_to user_path(user)
  end

  private
  def user_params
    if admin?
      params.require(:user).permit :name, :email, :password, :password_confirmation, :admin
    else
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end
  end

end
