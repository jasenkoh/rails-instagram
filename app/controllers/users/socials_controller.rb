class Users::SocialsController < ApplicationController
  def following
    @user = User.find(params[:id])
    @users = @user.following

    respond_to do |format|
      format.html
      format.json { render json: @users, status: 200, user: current_user }
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers

    respond_to do |format|
      format.html
      format.json { render json: @users, status: 200, user: current_user }
    end
  end
end
