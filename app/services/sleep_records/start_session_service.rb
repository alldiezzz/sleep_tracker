module SleepRecords
  class StartSessionService
    def self.call(user)
      cache_key = "sleep_session_id_#{user.id}"
      session_id = Rails.cache.read(cache_key)

      return ::OpenStruct.new(success?: true, data: { message: "Active sleep session exists.", session_id: session_id }) if session_id

      ActiveRecord::Base.transaction do
        user.lock!
        session_id = Rails.cache.read(cache_key)
        return ::OpenStruct.new(success?: true, data: { message: "Active sleep session exists.", session_id: session_id }) if session_id

        sleep_session = user.sleep_sessions.create!(start_time: Time.current)
        Rails.cache.write(cache_key, sleep_session.id, expires_in: 24.hours)
        OpenStruct.new(success?: true, data: { message: "Sleep session started successfully.", session_id: sleep_session.id })
      rescue ActiveRecord::RecordInvalid => e
        OpenStruct.new(success?: false, error: e.message)
      end
    end
  end
end
