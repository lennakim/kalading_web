module Admin::UsersHelper
  def set_class action_name, curr_name
    "active" if action_name == curr_name
  end

  def percentage_cal score
    "#{ (score / 100.0) * 100 }%"
  end
end
