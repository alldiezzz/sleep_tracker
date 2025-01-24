class SleepSessionSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :user_id, :total_duration_in_seconds

  has_many :sleep_events, serializer: SleepEventSerializer
  belongs_to :user
end
