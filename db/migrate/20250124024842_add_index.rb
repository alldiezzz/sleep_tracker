class AddIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :sleep_events, :event_type
  end
end
