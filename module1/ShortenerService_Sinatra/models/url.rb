class Url < ActiveRecord::Base
  validates :original_url, presence: true, format: URI::regexp(%w[http https])

  before_create :generate_short_url

  def generate_short_url
    self.short_url = SecureRandom.alphanumeric(6)
  end

  def increment_clicks
    self.clicks += 1
    self.save
  end
end