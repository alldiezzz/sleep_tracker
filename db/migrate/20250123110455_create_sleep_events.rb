class CreateSleepEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_events do |t|
      t.references :sleep_session, null: false, foreign_key: true
      t.string :event_type, null: false, default: "fall_asleep"
      t.datetime :event_time
      t.integer :duration_in_seconds

      t.timestamps
    end
  end
end
