class Channel < ActiveRecord::Base
  validates :name, presence: true

  before_create :generate_key

  def generate_key
    self.key = Digest::MD5.hexdigest "#{SecureRandom.urlsafe_base64(nil, false)}-#{Time.now.to_i}"
  end
end
