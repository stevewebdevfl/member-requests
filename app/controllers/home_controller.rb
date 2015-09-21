class HomeController < ApplicationController

  def index
    if session[:user_id]
      flash[:notice] = "(Please sign out to return to the Home page)"
      redirect_to show_path
    end
  end

end

