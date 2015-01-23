class PublicAccount < ActiveRecord::Base
  # It will auto generate weixin token and secret
  # include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey
  has_many :auth_infos
  has_many :diymenus, dependent: :destroy
  has_many :parent_menus, ->{includes(:sub_menus).where(parent_id: nil, is_show: true).order("sort").limit(3)}, class_name: "Diymenu", foreign_key: :public_account_id
  has_many :recv_messages
  has_many :reply_messages

  before_create :init_expired_at

  accepts_nested_attributes_for :diymenus, :allow_destroy => true

  def weixin_client
    client = WeixinAuthorize::Client.new(self.appid, self.appsecret)
    if token_expired?
      if client.is_valid?
        self.access_token = client.access_token
        set_token_expires_at
        return client
      else
        return nil
      end
    else
      return client
    end
  end

  def get_access_token
    if token_expired?
      client = weixin_client
      self.access_token = client.access_token if client
      set_token_expires_at
    end
    self.access_token
  end

  def get_jsapi_ticket
    if ticket_expired?
      access_token = get_access_token
      result = RestClient.get "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{access_token}&type=jsapi"
      self.jsapi_ticket = JSON.parse(result)["ticket"]
      set_ticket_expires_at
    end
    self.jsapi_ticket
  end

  def get_signature url
    noncestr = SecureRandom.hex[0..16]
    timestamp = Time.now.to_i
    jsapi_ticket = get_jsapi_ticket
    signature = Digest::SHA1.hexdigest("jsapi_ticket=#{jsapi_ticket}&noncestr=#{noncestr}&timestamp=#{timestamp}&url=#{url}")
    return signature, timestamp, noncestr
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

  private

  def token_expired?
    self.token_expires_at < Time.now
  end

  def ticket_expired?
    self.ticket_expires_at < Time.now
  end

  # The real expires time is 7200 seconds. But here I set all 3600 seconds.

  def set_token_expires_at
    self.token_expires_at = 3600.seconds.from_now
  end

  def set_ticket_expires_at
    self.ticket_expires_at = 3600.seconds.from_now
  end

  def init_expired_at
    self.token_expires_at = Time.now
    self.ticket_expires_at = Time.now
  end
end
