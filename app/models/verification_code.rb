require "#{Rails.root}/lib/yunpian_api.rb"

class VerificationCode < ActiveRecord::Base

  validates :phone_num, presence: true, phone: true

  before_create :generate_code
  before_create :set_expires_at

  after_create :send_sms

  def send_sms
    YunpianApi.send_to self.phone_num, "您的验证码是#{self.code}【卡拉丁】"
  end

  def generate_code
    self.code = [].tap { |e|  6.times{ e << (0..9).to_a.sample } }.join('')
  end

  def set_expires_at
    self.expires_at = 1.minutes.from_now.utc
  end

end
