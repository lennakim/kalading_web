class Message < ActiveRecord::Base
  validates :msg_id, presence: true, :uniqueness => :true
  belongs_to :user

  def set_message message
    self.to_user_name   = message.ToUserName
    self.from_user_name = message.FromUserName
    self.msg_type       = message.MsgType
    self.msg_id         = message.MsgId
    self.send("handle_#{message.MsgType}_message", message)
  end

  private

  def handle_text_message message
    self.content = message.Content
  end

  def handle_image_message message
    self.pic_url  = message.PicUrl
    self.media_id = message.MediaId
  end
end
