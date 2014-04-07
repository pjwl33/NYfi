class UsersController < ApplicationController

  before_action :authenticate, only: [:index, :show, :edit, :update, :destroy]

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
    if current_user == @user || admin?
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
      redirect_to user_path(params[:hotspot_id])
    else
      flash[:notice] = "That's not your account!"
      redirect_to user_path(user)
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :admin
  end

end
