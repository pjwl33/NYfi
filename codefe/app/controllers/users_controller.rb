class UsersController < ApplicationController

  before_action :authenticate, only: [:show, :edit, :update, :destroy]

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
    if current_user == @user
      @user.update user_params
      redirect_to @user
    else
      flash[:notice] = "Account Updated!"
      redirect_to @user
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :admin
  end

end
