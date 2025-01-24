class SleepSessionSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :total_duration_in_minutes

  has_many :sleep_events, serializer: SleepEventSerializer
  belongs_to :user
end
