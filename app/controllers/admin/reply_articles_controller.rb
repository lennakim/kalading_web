class Admin::ReplyArticlesController < Admin::MainController

  def new
    @reply_message = ReplyMessage.find params[:reply_message_id]
  end

  def edit
    @reply_message = ReplyMessage.find params[:reply_message_id]
    @reply_article = @reply_message.reply_articles.find params[:id]
  end

  def update
    @reply_message = ReplyMessage.find params[:reply_message_id]
    @reply_article = @reply_message.reply_articles.find params[:id]
    @reply_article.update article_params
    if @reply_article.save
      redirect_to admin_reply_message_path(@reply_message)
    else
      render 'edit'
    end
  end

  def create
    @reply_message = ReplyMessage.find params[:reply_message_id]
    @reply_article = @reply_message.reply_articles.create(article_params)
    redirect_to admin_reply_message_path(@reply_message)
  end

  def destroy
    @reply_message = ReplyMessage.find params[:reply_message_id]
    @reply_article = ReplyArticle.find params[:id]
    if @reply_article.destroy
      redirect_to admin_reply_message_path(@reply_message)
    end
  end

  private

  def article_params
    params.require(:reply_article).permit(:title, :description, :pic, :url, :pic_cache)
  end
end
