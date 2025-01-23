class CreateSleepSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_duration_in_seconds

      t.timestamps
    end
  end
end
