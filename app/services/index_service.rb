class IndexService
  def self.store(key, value)
    Rails.cache.write(key, value)
  end

  def self.get(key)
    Rails.cache.read(key)
  end

  def self.delete(key)
    Rails.cache.delete(key)
  end
end
