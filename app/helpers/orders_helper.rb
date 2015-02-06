module OrdersHelper

  def car_location
    ["京", "沪", "津", "渝", "浙", "苏", "粤", "闽", "湘", "鄂", "辽", "吉", "黑", "冀", "豫", "鲁", "陕", "甘", "青", "新", "晋", "川", "黔", "皖", "赣", "云", "蒙", "桂", "藏", "宁", "琼"]
  end

  def yidao_filter items, activity
    case activity.name
    when "yi-dao-yi-wan-smt-1" # low
      items.select{ |ele| ele["number"] =~ /金嘉护/ }
    when "yi-dao-yi-wan-smt-2" # mid
      items.select{ |ele| ele["number"] =~ /磁护/ }
    when "yi-dao-yi-wan-smt-3" # top
      items.select{ |ele| ele["brand"] == "美孚" }
    end
  end

  def can_cancel? order
    status = order["state"]
    ["未审核", "未分配", "未预约", "已预约"].include? status
  end

  def can_comment? order
    status = order["state"]
    status == "服务完成" && order["evaluated"] == 0
  end

  def order_statuses order
    status = order["state"]

    # 提交订单     0
    # 等待客服确认 2 / 客服已确认  3
    # 等待技师预约 3 / 技师已预约  4
    # 等待上门服务 4 / 订单完成    5
    #
    # 0: 未审核， 1：审核失败，2：未分配，3：未预约，4：已预约，5：服务完成，6：已交接，7：已回访，8：已取消，9：用户咨询, 10: 取消待审核

    content = [[nil, "提交订单"], ["等待客服确认", "客服已确认"], ["等待技师预约", "技师已预约"], ["等待上门服务", "订单完成"] ]

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

  def filter_parts parts, type
    if type == 'pm25'
      parts.select{ |part| part.keys.first == "空调滤清器" }
    elsif type == 'smt'
      parts.select{ |part| ["机油", "机滤"].include?(part.keys.first) }
    elsif type == 'bmt'
      parts
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
