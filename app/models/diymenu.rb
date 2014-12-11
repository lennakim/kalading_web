class Diymenu < ActiveRecord::Base
  belongs_to :public_account
  has_many :sub_menus, ->{where(is_show: true).order("sort").limit(5)}, class_name: "Diymenu", foreign_key: :parent_id

  CLICK_TYPE = "click"  # key
  VIEW_TYPE = "view"    # url

  def has_sub_menu?
    sub_menus.present?
  end

  def type
    key.present? ? CLICK_TYPE : VIEW_TYPE
  end

  def button_type(jbuilder)
    is_view_type? ? (jbuilder.url url) : (jbuilder.key key)
  end

  def is_view_type?
    type == VIEW_TYPE
  end
end
