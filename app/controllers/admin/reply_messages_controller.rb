class Admin::ReplyMessagesController < Admin::MainController
  def index
    @messages = ReplyMessage.all
  end

  def new
    @message = ReplyMessage.new
  end

  def create
    @message = ReplyMessage.new(reply_params)
    @message.msg_type = "text"
    if @message.save
      redirect_to admin_reply_messages_path
    else
      render :new
    end
  end

  def edit
    @message = ReplyMessage.find(params[:id])
  end

  def update
    @message = ReplyMessage.find(params[:id])
    if @message.update_attributes reply_params
      redirect_to admin_reply_messages_path
    else
      render :edit
    end
  end

  def destroy
    @message = ReplyMessage.find(params[:id])
    redirect_to admin_reply_messages_path if @message.destroy
  end

  private

  def reply_params
    params.require(:reply_message).permit(:content, :keyword)
  end
end
