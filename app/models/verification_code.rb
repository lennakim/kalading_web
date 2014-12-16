require "#{Rails.root}/lib/yunpian_api.rb"

class VerificationCode < ActiveRecord::Base

  validates :phone_num, presence: true, phone: true

  before_create :generate_code
  before_create :set_expires_at

  class << self

    def find_valid_one phone_num
      vcode = self.where(phone_num: phone_num).order("created_at DESC").first

      if vcode && !vcode.expired?
        vcode
      else
        vcode = self.create(phone_num: phone_num)
        vcode.valid? ? vcode : nil
      end
    end

  end

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
    self.expires_at = 50.seconds.from_now.utc
  end

end
