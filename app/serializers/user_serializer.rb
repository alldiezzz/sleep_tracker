class UserSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :sleep_sessions, serializer: SleepSessionSerializer
end
