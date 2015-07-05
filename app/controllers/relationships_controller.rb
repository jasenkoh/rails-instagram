class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user) if user
    respond_to do |format|
      format.js { render partial: 'shared/unfollow' }
    end
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user) if user
    respond_to do |format|
      format.js { render partial: 'shared/follow' }
    end
  end
end
