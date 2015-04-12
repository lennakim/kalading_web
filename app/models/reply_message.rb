class ReplyMessage < ActiveRecord::Base
  belongs_to :public_account
  has_many :reply_articles, dependent: :destroy

  validates_uniqueness_of :keyword
  validates :keyword, :msg_type,  presence:true

  def reply_message
    self.send("reply_#{msg_type}_message")
  end

  private
  def reply_text_message
    content
  end

  def reply_news_message
    reply_articles.all
  end

end
