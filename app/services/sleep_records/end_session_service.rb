module SleepRecords
  class EndSessionService
    def self.call(user, session_id)
      sleep_session = user.sleep_sessions.find_by(id: session_id)
      return unless sleep_session && sleep_session.end_time.nil?

      last_event = sleep_session.sleep_events.order(event_time: :desc).first

      if last_event.event_time < 1.minutes.ago
        sleep_session.update!(end_time: Time.current, total_duration_in_seconds: Time.current - sleep_session.start_time)
        Rails.cache.delete("sleep_session_id_#{user.id}")
      end
    end
  end
end
