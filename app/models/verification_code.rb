class VerificationCode < ActiveRecord::Base

  validates :phone_num, presence: true, phone: true

  before_create :generate_code
  before_create :set_expires_at

  def generate_code
    self.code = [].tap { |e|  6.times{ e << (0..9).to_a.sample } }.join('')
  end

  def set_expires_at
    self.expires_at = 1.hour.from_now.utc
  end

end
