require 'restclient'

module YunpianApi
  extend self

  def send_to mobile, content
    payload = {
      apikey: 'c9bd661a0aa53ee2fa262f1ad6c027dc',
      mobile: mobile,
      text: content
    }

    RestClient.post "http://yunpian.com/v1/sms/send.json", payload
  end
end
