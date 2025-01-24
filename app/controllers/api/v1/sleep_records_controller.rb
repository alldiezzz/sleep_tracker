class Api::V1::SleepRecordsController < Api::V1::BaseController
  before_action :set_user, only: [ :create, :add_event ]

  def create
    result = SleepRecords::StartSessionService.call(@user)

    if result.success?
      render json: result.data, status: :created
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def add_event
    result = SleepRecords::AddEventService.call(@user, params[:event_type])

    if result.success?
      render json: result.data, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
