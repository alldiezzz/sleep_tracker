# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create a user
user_names = %w[
  John Doe Jane Smith Alice Brown Bob White Charlie Black David Green
  Emily Johnson Michael Williams Sarah Jones Chris Miller Jessica Davis
  Daniel Wilson Laura Moore Kevin Taylor Megan Anderson Brian Thomas
  Amanda Jackson
]

user_names.each do |name|
  User.find_or_create_by!(name: name)
end

User.all.each do |user|
  start_time = Time.current - rand(1..30).days - rand(1..24).hours - rand(1..60).minutes
  end_time = start_time + rand(6..8).hours
  sleep_session = user.sleep_sessions.create!(start_time: start_time, end_time: end_time, total_duration_in_seconds: end_time - start_time)

  if rand(0..1) == 1
    sleep_session.sleep_events.create!(event_type: "wake_up", event_time: start_time + 2.hour)
    sleep_session.sleep_events.create!(event_type: "fall_asleep", event_time: start_time + 150.minutes)
    sleep_session.sleep_events.create!(event_type: "wake_up", event_time: start_time + end_time + 1.hour)
  else
    sleep_session.sleep_events.create!(event_type: "wake_up", event_time: start_time + end_time + 1.hour)
  end
end
