class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.authenticate params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back #{@user.name}!"
      redirect_to @user
    else
      flash[:notice] = "Forgot your password?"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end