class ReplyMessage < ActiveRecord::Base
  belongs_to :public_account

  validates_uniqueness_of :keyword
  validates :keyword, :msg_type, :content,  presence:true

  def reply_message
    self.send("reply_#{msg_type}_message")
  end

  private
  def reply_text_message
    content
  end

end
