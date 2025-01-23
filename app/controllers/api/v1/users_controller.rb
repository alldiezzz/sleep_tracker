class Api::V1::UsersController < Api::V1::BaseController
  def user_params
    params.require(:user).permit(:name)
  end
end
