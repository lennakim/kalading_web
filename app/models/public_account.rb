class PublicAccount < ActiveRecord::Base
  # It will auto generate weixin token and secret
  # include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  has_many :auth_infos
  has_many :diymenus, dependent: :destroy
  has_many :parent_menus, ->{includes(:sub_menus).where(parent_id: nil, is_show: true).order("sort").limit(3)}, class_name: "Diymenu", foreign_key: :public_account_id
  has_many :recv_messages

  accepts_nested_attributes_for :diymenus, :allow_destroy => true

  def weixin_client
    client = WeixinAuthorize::Client.new(self.appid, self.appsecret)
    client.is_valid? ? client : "invalid appid or appsecret"
  end

  def build_menu
    Jbuilder.encode do |json|
      json.button (parent_menus) do |menu|
        json.name menu.name
        if menu.has_sub_menu?
          json.sub_button(menu.sub_menus) do |sub_menu|
            json.type sub_menu.type
            json.name sub_menu.name
            sub_menu.button_type(json)
          end
        else
          json.type menu.type
          menu.button_type(json)
        end
      end
    end
  end
end
