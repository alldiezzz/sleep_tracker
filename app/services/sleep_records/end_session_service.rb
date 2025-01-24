module SleepRecords
  class EndSessionService
    def self.call(user, session_id = nil)
      cache_key = "sleep_session_id_#{user.id}"
      session_id = session_id || Rails.cache.read(cache_key)

      return OpenStruct.new(success?: false, error: "No active sleep session found.") if session_id.nil?

      ActiveRecord::Base.transaction do
        sleep_session = user.sleep_sessions.lock.find_by(id: session_id)
        return OpenStruct.new(success?: false, error: "Active sleep session not found.") if sleep_session.nil?

        last_event = sleep_session.sleep_events.order(event_time: :desc).first
        if last_event&.event_type == "wake_up"
          sleep_session.update!(end_time: last_event.event_time, total_duration_in_seconds:  last_event.event_time - sleep_session.start_time)
          Rails.cache.delete(cache_key)
          OpenStruct.new(success?: true, data: { message: "Sleep session ended successfully.", session_id: sleep_session.id })
        end
      rescue ActiveRecord::RecordInvalid => e
        OpenStruct.new(success?: false, error: e.message)
      end
    end
  end
end
