class SleepEventSerializer < ActiveModel::Serializer
  attributes :id, :event_time, :duration_in_seconds, :sleep_session_id
end
