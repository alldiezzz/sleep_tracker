class DashboardsController < ApplicationController
  before_action :set_user, only: :index
  def index
    @sleep_sessions = @user.sleep_sessions
    @followed_sleep_sessions = @user.followed.map(&:sleep_sessions).flatten
  end
end
