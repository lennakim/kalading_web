module Admin::AdminHelper
  def can? action
    return false if !current_user

    if action == :manage
      current_user.role == "administrator"
    elsif action == :edit
      current_user.role == "editor" ||
      current_user.role == "administrator"
    end
  end
end
