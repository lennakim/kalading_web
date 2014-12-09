class Message < ActiveRecord::Base
  belongs_to :user

  def self.save_txt_message(name, message)
    user = User.find_by(openid: message.FromUserName)
    user = User.save_weixin_user name, message.FromUserName unless user

    new_message = user.messages.new
    new_message.to_user_name   = message.ToUserName
    new_message.from_user_name = message.FromUserName
    new_message.msg_type       = message.MsgType
    new_message.content        = message.Content
    new_message.msg_id         = message.MsgId
    new_message.save!
  end

  def self.save_img_message(name, message)
    user = User.find_by(openid: message.FromUserName)
    user = User.save_weixin_user name, message.FromUserName unless user

    new_message = user.messages.new
    new_message.to_user_name   = message.ToUserName
    new_message.from_user_name = message.FromUserName
    new_message.msg_type       = message.MsgType
    new_message.pic_url        = message.PicUrl
    new_message.media_id       = message.MediaId
    new_message.msg_id         = message.MsgId
    new_message.save!
  end

end
