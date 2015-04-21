class Admin::ReplyMessagesController < Admin::MainController

  def index
    @reply_messages = ReplyMessage.all
  end

  def new
    @reply_message = ReplyMessage.new
  end

  def show
    @reply_message = ReplyMessage.find params[:id]
  end

  def edit
    @reply_message = ReplyMessage.find params[:id]
  end

  def create
    account = PublicAccount.find_by(name:"kaladingcom")
    @reply_message = account.reply_messages.new message_params
    if @reply_message.save
      redirect_to admin_reply_message_path(@reply_message.id)
    else
      render 'new'
    end
  end

  def update
    @reply_message = ReplyMessage.find params[:id]
    @reply_message.update message_params

    if @reply_message.save
      redirect_to admin_reply_messages_path
    else
      render 'edit'
    end
  end

  def destroy
    @reply_message = ReplyMessage.find params[:id]
    if @reply_message.destroy
      redirect_to admin_reply_messages_path
    end
  end

  private
  def message_params
    params.require(:reply_message).permit(:content, :keyword, :msg_type)
  end
end
