class Message < ActiveRecord::Base
  belongs_to :user

  def self.save_txt_message(message)
    user = User.find_by_openid message.FromUserName
    user = User.save_weixin_user PublicAccount.get_weixin_id[0], message.FromUserName unless user
    new_message = user.messages.new
    new_message.to_user_name = message.ToUserName
    new_message.from_user_name = message.FromUserName
    new_message.msg_type = message.MsgType
    new_message.content = message.Content
    new_message.msg_id = message.MsgId
    new_message.save!
  end

end
