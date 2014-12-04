require "#{Rails.root}/lib/server_api.rb"

class OrdersController < ApplicationController

  def select_car
  end

  def refresh_price
    car_id = params["order"]["car_id"]
    parts = params["order"]["parts"].values
    payload = {
      "parts" => parts
    }
    result = Order.refresh_price car_id, payload
    render json: { result: result }
  end

  def select_item
    # @result = Order.items_for params[:car_id]

    @result =
      {"price"=>981.0,
       "price_without_discount"=>981.0,
       "service_price"=>150.0,
       "discount"=>{},
       "pic_url"=>
    "http://intranet.kalading.com/assets/car_blue-80ae63c118fa176b59fdd2b8b63b2f72.png",
      "name"=>"奥迪(一汽) A6 上门保养",
      "parts"=>
    [{"机油"=>
      [{"brand"=>"美孚",
        "number"=>"美孚1号 0W-40",
        "price"=>595.0,
        "quantity"=>462}]},
        {"机滤"=>
         [{"brand"=>"汉格斯特 Hengst",
           "number"=>"5280cbab098e71d85e000942",
           "price"=>58.0,
           "quantity"=>2}]},
           {"空气滤清器"=>
            [{"brand"=>"曼牌 Mann",
              "number"=>"5246c785098e71092800014e",
              "price"=>52.0,
              "quantity"=>3}]},
              {"空调滤清器"=>
               [{"brand"=>"曼牌 Mann",
                 "number"=>"5246c785098e710928000151",
                 "spec"=>"双效活性炭",
                 "price"=>126.0,
                 "quantity"=>6}]}],
                 "applicable_parts"=>
               [{"空调滤清器"=>
                 [{"brand"=>"卡拉丁",
                   "number"=>"539d52749a94e4de840005c5",
                   "spec"=>"PM2.5空调滤清器",
                   "price"=>119.0,
                   "quantity"=>100},
                   {"brand"=>"汉格斯特 Hengst",
                    "number"=>"5280cba8098e71d85e00082a",
                    "spec"=>"双效活性炭",
                    "price"=>118.0,
                    "quantity"=>5},
                    {"brand"=>"曼牌 Mann",
                     "number"=>"5246c785098e710928000151",
                     "spec"=>"双效活性炭",
                     "price"=>126.0,
                     "quantity"=>6},
                     {"brand"=>"马勒 ",
                      "number"=>"5298b996098e716daf00122b",
                      "spec"=>"双效活性炭",
                      "price"=>90.0,
                      "quantity"=>4}]},
                      {"空气滤清器"=>
                       [{"brand"=>"汉格斯特 Hengst",
                         "number"=>"5280cb92098e71d85e000206",
                         "price"=>44.0,
                         "quantity"=>2},
                         {"brand"=>"曼牌 Mann",
                          "number"=>"5246c785098e71092800014e",
                          "price"=>52.0,
                          "quantity"=>3},
                          {"brand"=>"马勒 ",
                           "number"=>"5298b989098e716daf000ef3",
                           "price"=>28.0,
                           "quantity"=>12}]},
                           {"机滤"=>
                            [{"brand"=>"汉格斯特 Hengst",
                              "number"=>"5280cbab098e71d85e000942",
                              "price"=>58.0,
                              "quantity"=>2},
                              {"brand"=>"马勒 ",
                               "number"=>"528f6c407ef560b0410024b7",
                               "price"=>49.0,
                               "quantity"=>5},
                               {"brand"=>"曼牌 Mann",
                                "number"=>"5246c785098e71092800014f",
                                "price"=>65.0,
                                "quantity"=>7}]},
                                {"机油"=>
                                 [{"brand"=>"美孚", "number"=>"美孚1号 0W-40", "price"=>595.0, "quantity"=>462},
                                  {"brand"=>"嘉实多",
                                   "number"=>"极护 SN 0W-40",
                                   "price"=>672.0,
                                   "quantity"=>73},
                                   {"brand"=>"嘉实多",
                                    "number"=>"磁护 SN 5W-40",
                                    "price"=>492.0,
                                    "quantity"=>99},
                                    {"brand"=>"壳牌",
                                     "number"=>"灰喜力ULTRA 5W-40",
                                     "price"=>294.0,
                                     "quantity"=>1}]}]}

  end

  def place_order
  end

end
