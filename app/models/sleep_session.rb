class SleepSession < ApplicationRecord
  belongs_to :user
  has_many :sleep_events, dependent: :destroy

  def total_duration_in_minutes
    (total_duration_in_seconds / 60).to_i
  rescue
    0
  end
end
