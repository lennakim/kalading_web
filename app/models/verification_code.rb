class VerificationCode < ActiveRecord::Base

  validates :phone_num, presence: true, phone: true

  before_create :generate_code
  before_create :set_expires_at

  def expired?
    self.expires_at < Time.now
  end

  def send_sms
    result = YunpianApi.send_to self.phone_num, "您的验证码是#{self.code}【卡拉丁】"

    JSON.parse(result)["code"] == 0
  end

  def generate_code
    self.code = [].tap { |e|  6.times{ e << (0..9).to_a.sample } }.join('')
  end

  def set_expires_at
    self.expires_at = 15.minutes.from_now.utc
  end


  def self.interval?(phone, interval = 60)
    last_code = VerificationCode.where(phone_num: phone).order("created_at desc").first

    last_code.blank? || (last_code && (Time.now - last_code.created_at > interval))
  end
end
