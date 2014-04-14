class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.authenticate params[:password]
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome back #{@user.name}!"
    else
      render 'new', notice: "Forgot your password?"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end