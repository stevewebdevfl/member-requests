class UsersController < ApplicationController

  def show
    if !session[:user_id]
      flash[:notice] = "(Please log in to access the Session Home page)"
      redirect_to home_path
    end
  end

  def new
    if session[:user_id]
      flash[:notice] = "(If you would like to add a new user, please log out)"
      redirect_to show_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You have been added as a new user.  Please sign in."
      redirect_to login_path
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to signup_path
    end
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end


  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
end
