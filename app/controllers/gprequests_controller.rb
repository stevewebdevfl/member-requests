class GprequestsController < ApplicationController

  def user_vote
    @gprequest = Gprequest.find(params[:id])
    @gprequest.votes << Vote.create(user: current_user)
    @gprequest.save
    if @gprequest.save
      flash[:success] = "Your vote has been recorded"
      redirect_to gprequests_path
    end
  end

  def new
    if !session[:user_id]
      flash[:notice] = "(Sign in to access the Post Requests page)"
      redirect_to home_path
    else
      @gprequest = Gprequest.new
    end
  end

  def index
    if !session[:user_id]
      flash[:notice] = "(Sign in to access the Open Requests page)"
      redirect_to home_path
    else
      @votecount = Vote.count
      @gprequests = Gprequest.all
      @allow_vote = true
      @vote_found = Vote.find_by(user_id: session[:user_id])
      if @vote_found
        @allow_vote = false 
      end
    end
  end

  def show
    if !session[:user_id]
      flash[:notice] = "(Sign in to access the Your Requests page)"
      redirect_to home_path
    else
      @gprequests = Gprequest.where(user_id: session[:user_id])
    end
  end

  def create
    @gprequest = Gprequest.new(gprequest_params)
    if @gprequest.save
      flash[:success] = "Your request has been posted"
      redirect_to show_req_path
    else
      flash[:error] = "Your request did not post (confirm title entry)"
      redirect_to post_path
    end
  end

  def rank
    if !session[:user_id]
      flash[:notice] = "(Sign in to access the Rank Requests page)"
      redirect_to home_path
    else
      @gprequests = Gprequest.all
      rank_array = []     # an array of arrays
      @gprequests.each do |gprequest|
        rank_data = []
        vote_num = gprequest.votes.count
        rank_data = [gprequest.id, vote_num]
        rank_array << rank_data
      end
      @gprequest_rank = rank_array.sort do |a, b|
        b[1] <=> a[1]
      end
    end
  end

  def vote_count
    vote_count = gprequest.votes.count
  end

  def destroy
  end

  private

  def gprequest_params
    params.require(:gprequest).permit(:id, :user_id, :title, :description)
  end

end

