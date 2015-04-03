class Admin::ReplyMessagesController < Admin::MainController
  inherit_resources

  actions :all, :except => [ :show ]

  def create
    account = PublicAccount.find_by(name:"kaladingcom")
    account.reply_messages.new permitted_params[:reply_message]
    create!
  end

  private
  def permitted_params
    params.permit(:reply_message => [:content, :keyword, :msg_type])
  end
end
