class SessionsController < ApplicationController
  def new
    if session[:user_id]
      flash[:notice] = "You are already logged in"
      redirect_to home_path
    end
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "You are now loged in"
      session[:user_id] = @user.id
      session[:email] = @user.email
      redirect_to show_path
    else
      flash[:alert] = "There was a problem logging you in."
      redirect_to login_path
    end
  end

  def destroy
    if !session[:user_id]
      flash[:notice] = "(Sign out is not possible unless you are signed in)"
      redirect_to home_path
    else
      session.clear
      flash[:notice] = "You are now logged off"
      redirect_to "/"
    end
  end

end
