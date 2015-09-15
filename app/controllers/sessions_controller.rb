class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "You've been logged in."
      session[:user_id] = @user.id
      session[:email] = @user.email
      redirect_to show_path
    else
      flash[:alert] = "There was a problem logging you in."
      # redirect_to login_path
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been logged out successfully."
    redirect_to "/"
  end

end
