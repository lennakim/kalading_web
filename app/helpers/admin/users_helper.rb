module Admin::UsersHelper
  def set_class action_name, curr_name
    "active" if action_name == curr_name
  end
end
