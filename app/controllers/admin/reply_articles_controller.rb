class Admin::ReplyArticlesController < Admin::MainController

  def create
    @reply_message = ReplyMessage.find params[:reply_message_id]
    @reply_article = @reply_message.reply_articles.create(article_params)
    redirect_to admin_reply_message_path(@reply_message)
  end

  private

  def article_params
    params.require(:reply_article).permit(:title, :description, :pic, :url)
  end
end
