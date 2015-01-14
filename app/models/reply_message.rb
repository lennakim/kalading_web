class ReplyMessage < ActiveRecord::Base
  belongs_to :public_account

  def reply_message
    self.send("reply_#{msg_type}_message")
  end

  private

  def reply_text_message
    content
  end

end
