class WechatPayController < ApplicationController
  def pay
    params = {
      body: "测试商品",
      out_trade_no: "test003",
      total_fee: 1,
      spbill_create_ip: '127.0.0.1',
      notify_url: 'http://ohcoder.pagekite.me/sessions/wechat_pay',
      trade_type: 'NATIVE'
    }
    r = WxPay::Service.invoke_unifiedorder params

    if r.success?
      Rails.logger.info("-"*60)
    end
  end
end
