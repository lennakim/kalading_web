module OrdersHelper

  def user_default_address
    if current_user && current_user.default_address
      current_user.default_address.full_address
    else
      cookies[:address]
    end
  end

  def car_location
    ["京", "沪", "津", "渝", "浙", "苏", "粤", "闽", "湘", "鄂", "辽", "吉", "黑", "冀", "豫", "鲁", "陕", "甘", "青", "新", "晋", "川", "黔", "皖", "赣", "云", "蒙", "桂", "藏", "宁", "琼"]
  end

  def product_available? product
    product.cities.map(&:name).include? current_city_name
  end

  def custom_activity
    ['yi-dao-yi-wan-smt-1',
     'yi-dao-yi-wan-smt-2',
     'yi-dao-yi-wan-smt-3',
     'gan-ji-smt-1',
     'gan-ji-smt-2',
     'gan-ji-smt-3',
     'gulf-oil-50'
    ]
  end

  def yidao_filter items, activity
    case activity.name
    when "yi-dao-yi-wan-smt-1" # low
      items.select{ |ele| ele["number"] =~ /金嘉护/ }
    when "gan-ji-smt-1"
      items.select{ |ele| ele["number"] =~ /金嘉护/ }

    when "yi-dao-yi-wan-smt-2" # mid
      items.select{ |ele| ele["number"] =~ /磁护/ }
    when "gan-ji-smt-2"
      items.select{ |ele| ele["number"] =~ /磁护/ }

    when "yi-dao-yi-wan-smt-3" # top
      items.select{ |ele| ele["brand"] == "美孚" }
    when "gan-ji-smt-3"
      items.select{ |ele| ele["number"] =~ /极护/ }

    when 'gulf-oil-50'
      items.select{ |ele| ele["brand"] =~ /海湾/ }
    end
  end

  def item_icon_mapping part_name
    {
      "机油" => "oil",
      "机滤" => "filter",
      "空调滤清器" => "air-filter",
      "空气滤清器" => "air-cleaner",
      "电瓶" => "battery"
    }[part_name]
  end

  def can_cancel? order
    ["未审核", "未分配", "未预约", "已预约"].include? order['state'].split('-')[1]
  end

  def can_comment? order
    state_str = order["state"].split('-')[1]
    ["服务完成", "已回访", "已交接"].include?(state_str) && !order["evaluated"]
  end

  def state_name state_str
    mapping = {
      "未支付"   => %w-未支付-,
      "等待分配" => %w-未审核 已审核-,
      "等待服务" => %w-已预约-,
      "已完成"   => %w-已评价 未评价 服务完成 已交接 已回访-,
      "已取消"   => %w-已取消-
    }
    index = mapping.values.index{|arr| arr.include?(state_str)}
    mapping.keys[index]
  end

  def order_statuses order
    status = order["state"].split('-')[1]

    # 提交订单     0
    # 等待客服确认 2 / 客服已确认  3
    # 等待技师预约 3 / 技师已预约  4
    # 等待上门服务 4 / 订单完成    5
    #
    # 0: 未审核， 1：审核失败，2：未分配，3：未预约，4：已预约，5：服务完成，6：已交接，7：已回访，8：已取消，9：用户咨询, 10: 取消待审核

    content = [
      [nil, "提交订单"],
      ["等待客服确认", "客服已确认"],
      ["等待技师预约", "技师已预约"],
      ["等待上门服务", "订单完成"]
    ]

    statuses = {
      "未审核"     => [[1], [0], [0], [0]],
      "未分配"     => [[1], [0], [0], [0]],
      "未预约"     => [[1], [1], [0], [0]],
      "已预约"     => [[1], [1], [1], [0]],
      "服务完成"   => [[1], [1], [1], [1]]
    }

    if statuses[status]
      statuses[status].each_with_index.map do |s, i|
        [ content[i][s.first], (s.first == 1) ]
      end
    else
      nil
    end
  end

  def default_parts result
    result["parts"].map{ |part| part.values[0][0]["number"] }
  end

  def get_recommend_part parts, key
    index = parts.map(&:keys).index([key])
    curr_parts = parts[index].values[0]

    curr_parts.select{|item| item['recommended'] == 1 && item['quantity'] != 0 }.first || curr_parts.select{ |item|  item['quantity'] != 0}.first

  end

  def recommend_part_index parts, key, recommend_part
    index = parts.map(&:keys).index([key])
    curr_parts = parts[index].values[0]
    curr_parts.index{ |part| part['number'] == recommend_part['number'] }

  end

  def filter_parts parts, type
    if type == 'pm25'
      parts.select{ |part| part.keys.first == "空调滤清器" }
    elsif type == 'smt'
      parts.select{ |part| ["机油", "机滤"].include?(part.keys.first) }
    elsif type == 'bmt'
      parts.select{ |part| ["空气滤清器","空调滤清器","机油", "机滤"].include?(part.keys.first) }
    elsif type == 'bty'
      parts.select{ |part| ["电瓶"].include?(part.keys.first) }
    end
  end

  def selected_item_index defaults, part_items

    conditions = [
      lambda {|part_item| part_item["brand"].match("卡拉丁")},
      lambda {|part_item| defaults.include?(part_item["number"])}
    ]

    item = nil
    conditions.each do |cond|
      item = part_items.select(&cond).first
      break if item
    end

    part_items.index item
  end

  def selected_attr selected
    selected ? "selected" : ""
  end

  def display_item_name name, brand, number
    if name == "机油"
      "#{brand} #{number}"
    else
      brand
    end
  end

end
