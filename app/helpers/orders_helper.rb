module OrdersHelper

  def default_parts result
    result["parts"].map{ |part| part.values[0][0]["number"] }
  end

  def filter_parts parts, type
    if type == 'pm25'
      parts.select{ |part| part.keys.first == "空调滤清器" }
    else
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
