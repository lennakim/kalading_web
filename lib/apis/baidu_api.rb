require 'restclient'

module BaiduApi
  extend self

  def ip_to_city ip

    result = RestClient.get "http://api.map.baidu.com/location/ip", \
      {params: { ak: Settings.baidu_ak, ip: ip } }

    JSON.parse(result)["address"] rescue nil

  end
end
