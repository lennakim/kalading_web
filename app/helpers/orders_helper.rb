module OrdersHelper

  def related_applicable_parts result, item_name
    result["applicable_parts"].select{|apart| apart.keys[0] == item_name }
  end

  def applicable_items apart_items, item_name, except: item_brand
    apart_items[item_name].reject{|apart_item| apart_item["brand"] == except }
  end

end
