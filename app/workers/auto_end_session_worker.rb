class AutoEndSessionWorker
  include Sidekiq::Worker

  def perform(user_id, session_id)
    user = User.find_by(id: user_id)
    return unless user

    SleepRecords::EndSessionService.call(user, session_id)
  end
end
