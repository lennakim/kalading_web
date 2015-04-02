class Admin::ReplyMessagesController < Admin::MainController
  inherit_resources

  actions :all, :except => [ :show ]

  private
  def permitted_params
    params.permit(:reply_message => [:content, :keyword, :msg_type])
  end
end
