class RecvMessage < ActiveRecord::Base
  belongs_to :public_accounts
  validates :msg_id, presence: true, :uniqueness => :true

  def set_info info
    self.to_user_name   = info.ToUserName
    self.from_user_name = info.FromUserName
    self.msg_type       = info.MsgType
    self.msg_id         = info.MsgId
    self.send("handle_#{info.MsgType}_info", info)
  end

  private

  def handle_text_info info
    self.content = info.Content
  end

  def handle_image_info info
    self.pic_url  = info.PicUrl
    self.media_id = info.MediaId
  end
end
