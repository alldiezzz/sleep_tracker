class DashboardsController < ApplicationController
  before_action :set_user, only: :index
  def index
    User.reindex_sleep_sessions
    @sleep_sessions = IndexService.get("sleep_session_user_#{@user.id}")&.dig(:sleep_sessions) || []
    @followed_sleep_sessions = @user.followed.flat_map { |fu| IndexService.get("sleep_session_user_#{fu.id}") }
  end
end
