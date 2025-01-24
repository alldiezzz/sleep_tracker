module SleepRecords
  class AddEventService
    def self.call(user, event_type)
      cache_key = "sleep_session_id_#{user.id}"
      session_id = Rails.cache.read(cache_key)

      sleep_session = user.sleep_sessions.find_by(id: session_id)
      return OpenStruct.new(success?: false, error: "Active sleep session not found.") if sleep_session.nil?

      ActiveRecord::Base.transaction do
        unless %w[fall_asleep wake_up].include?(event_type)
          return OpenStruct.new(success?: false, error: "Invalid event type.")
        end

        debugger
        sleep_session.sleep_events.create!(event_type: event_type, event_time: Time.current)

        AutoEndSessionWorker.perform_in(1.hour, user.id, sleep_session.id) if event_type == "wakeup"

        OpenStruct.new(success?: true, data: { message: "Sleep event recorded.", session_id: sleep_session.id, event_type: event_type })
      rescue ActiveRecord::RecordInvalid => e
        OpenStruct.new(success?: false, error: e.message)
      end
    end
  end
end
