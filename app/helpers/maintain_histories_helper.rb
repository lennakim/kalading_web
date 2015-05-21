module MaintainHistoriesHelper

  def light_name_mapper key
    {
      'high_beam'    => '远光灯',
      'low_beam'     => '近光灯',
      'turn_light'   => '转向灯',
      'fog_light'    => '雾灯',
      'small_light'  => '小灯',
      'backup_light' => '倒车灯',
      'brake_light'  => '刹车灯'
    }[key.to_s]
  end

  def extract_arr_with hash, keys
    if keys
      hash.select{ |k, v| keys.map(&:to_s).include?(k.to_s) }.values.join(', ')
    else
      ""
    end
  end

  def light_desc_mapper keys

    keys = keys.map(&:to_i)

    hash = {
      '0' => '亮',
      '1' => '无法检测',
      '2' => '左不亮',
      '3' => '右不亮',
      '4' => '左前不亮',
      '5' => '右前不亮',
      '6' => '左后不亮',
      '7' => '右后不亮',
      '8' => '高位不亮',
      '9' => '后雾不亮'
    }

    extract_arr_with hash, keys
  end

  def air_filter_desc_mapper key
    {
      '0' => '干净',
      '1' => '脏',
      '2' => '严重污浊'
    }[key.to_s]
  end

  def cabin_filter_desc_mapper key
    {
      '0' => '干净',
      '1' => '脏',
      '2' => '严重污浊'
    }[key.to_s]
  end

  def antifreeze_desc_mapper key
    {
      '0' => '清澈',
      '1' => '浑浊',
      '2' => '很脏',
      '3' => '无法检测'
    }[key.to_s]
  end

  def antifreeze_position_mapper key
    {
      '0' => '高位',
      '1' => '中位',
      '2' => '低位',
      '3' => '无法检测'
    }[key.to_s]
  end

  def steering_oil_desc_mapper key
    {
      '0' => '清澈',
      '1' => '浑浊',
      '2' => '很脏',
      '3' => '无法检测'
    }[key.to_s]
  end

  def steering_oil_position_mapper key
    {
      '0' => '高位',
      '1' => '中位',
      '2' => '低位',
      '3' => '无法检测'
    }[key.to_s]
  end

  def gearbox_oil_position_mapper key
    {
      '0' => '高位',
      '1' => '中位',
      '2' => '低位',
      '3' => '无法检测'
    }[key.to_s]
  end

  def glass_water_desc_mapper key
    {
      '0' => '满',
      '1' => '缺少'
    }[key.to_s]
  end

  def battery_desc_mapper key
    {
      '0' => '良好',
      '1' => '破损',
      '2' => '泄露',
      '3' => '无法检测'
    }[key.to_s]
  end

  def battery_head_desc_mapper key
    {
      '0' => '良好',
      '1' => '腐蚀',
      '2' => '无法检测'
    }[key.to_s]
  end

  def engine_hose_and_line_desc_mapper key
    {
      '0' => '正常',
      '1' => '轻微老化',
      '2' => '严重老化'
    }[key.to_s]
  end

  def front_wiper_desc_mapper key
    {
      '0' => '正常',
      '1' => '建议更换'
    }[key.to_s]
  end

  def back_wiper_desc_mapper key
    {
      '0' => '正常',
      '1' => '建议更换',
      '2' => '无此项'
    }[key.to_s]
  end

  def extinguisher_desc_mapper key
    {
      '0' => '有',
      '1' => '无',
      '2' => '未检测'
    }[key.to_s]
  end

  def warning_board_desc_mapper key
    {
      '0' => '有',
      '1' => '无',
      '2' => '未检测'
    }[key.to_s]
  end

  def gearbox_oil_desc_mapper key
    {
      '0' => '清澈',
      '1' => '浑浊',
      '2' => '很脏',
      '3' => '无法检测'
    }[key.to_s]
  end

  def status_class value
    value.to_s == '0' ? 'on' : 'off'
  end

  def status_class_arr values
    if values
      values = values.map &:to_i
      values.map(&:to_s).include?('0') ? 'on' : 'off'
    else
      'on'
    end
  end

  def wheel_name_mapper key
    {
      'left_front'  => '左前',
      'left_back'   => '左后',
      'right_front' => '右前',
      'right_back'  => '右后',
      'spare'       => '备胎'
    }[key.to_s]
  end

  def spare_tire_desc_mapper key
    {
      '0' => '有',
      '1' => '无',
      '2' => '未检测'
    }[key.to_s]
  end

  def factory_data_checked_value_mapper key
    {
      'false' => '不可检测',
      'true'  => '可检查(默认值)'
    }[key.to_s]
  end

  def ageing_mapper key
    {
      '0' => '轻微',
      '1' => '一般',
      '2' => '严重'
    }[key.to_s]
  end

  def tread_desc_mapper keys
    hash = {
      '0' => '正常',
      '1' => '局部开裂',
      '2' => '中间磨损严重',
      '3' => '两侧磨损严重',
      '4' => '异物扎胎'
    }
    extract_arr_with hash, keys
  end

  def sidewall_desc_mapper keys
    hash = {
      '0' => '正常',
      '1' => '局部开裂',
      '2' => '严重割伤',
      '3' => '两侧磨损严重',
      '4' => '鼓包',
      '5' => '异常磨损'
    }
    extract_arr_with hash, keys
  end

  def brake_pad_checked_mapper key
    {
      'false' => '不可检测',
      'true'  => '可检查(默认值)'
    }[key.to_s]
  end

  def brake_disc_desc_mapper keys
    hash = {
      '0' => '无不规则磨损',
      '1' => '有不规则磨损',
      '2' => '建议更换',
      '3' => '不建议更换',
      '4' => '无法检测'
    }
    extract_arr_with hash, keys
  end

  def oil_position_mapper key
    {
      '0' => '正常（介于L和H之间）',
      '1' => '高位',
      '2' => '低位'
    }[key.to_s]
  end

  def oil_desc_mapper key
    {
      '0' => '浑浊',
      '1' => '很脏',
      '2' => '严重污浊'
    }[key.to_s]
  end

end
