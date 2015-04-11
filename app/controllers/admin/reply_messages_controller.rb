class Admin::ReplyMessagesController < Admin::MainController
  inherit_resources

  actions :all, :except => [ :show ]

  def create
    ap permitted_params[:reply_message]
    @reply_message = ReplyMessage.new permitted_params[:reply_message]
    account = PublicAccount.find_by(name:"kaladingcom")
    account.reply_messages << @reply_message
    create!
  end

  private
  def permitted_params
    params.permit(:reply_message => [:content, :keyword, :msg_type])
  end
end
