class ReplyArticle < ActiveRecord::Base
  belongs_to :reply_message
  mount_uploader :picurl, PhontoUpLoader

end
