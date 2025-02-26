class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [ :sleep_sessions, :followed_sleep_sessions ]
  before_action :reindex_sleep_sessions, only: [ :sleep_sessions, :followed_sleep_sessions ]

  def follow
    follow = Follow.find_or_initialize_by(
      follower_id: follow_params[:follower_id],
      followed_id: follow_params[:followed_id]
    )

    if follow.persisted?
      render json: { message: "You are already following this user" }, status: :ok
    elsif follow.save
      render json: { message: "Successfully followed user" }, status: :created
    else
      render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def unfollow
    follow = Follow.find_by(follower_id: follow_params[:follower_id], followed_id: follow_params[:followed_id])

    if follow
      follow.destroy
      render json: { message: "Successfully unfollowed the user" }, status: :ok
    else
      render json: { error: "Follow relationship not found" }, status: :not_found
    end
  end

  def sleep_sessions
    render json: IndexService.get("sleep_session_user_#{@user.id}")
  end

  def followed_sleep_sessions
    render json: @user.followed.map { |followed_user| IndexService.get("sleep_session_user_#{followed_user.id}") }.flatten
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end

  def reindex_sleep_sessions
    User.reindex_sleep_sessions
  end
end
