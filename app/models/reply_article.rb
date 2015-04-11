class ReplyArticle < ActiveRecord::Base
  belongs_to :reply_message
end
