class SleepEvent < ApplicationRecord
  belongs_to :sleep_session

  enum event_type: {
    fall_asleep: "fall_asleep",
    wake_up: "wake_up",
    nap: "nap"
  }
end
