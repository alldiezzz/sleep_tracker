class SleepSession < ApplicationRecord
  belongs_to :user
  has_many :sleep_events, dependent: :destroy
end
