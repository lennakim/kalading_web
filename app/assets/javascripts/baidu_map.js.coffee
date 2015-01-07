$ ->

  # 建立一个自动完成的对象
  ac = new BMap.Autocomplete({
    "input" : "address_detail"
  })

  $("#address_detail").on "focus", ->
    $(@).closest(".form-group").removeClass('has-error')
    $(".add-address > button").removeClass("disabled")

  window.ac = ac

  ac.setInputValue "北京市海淀区"

  # 鼠标放在下拉列表上的事件
  ac.addEventListener "onhighlight", (e) ->
    str = ""
    _value = e.fromitem.value
    value = ""

    if e.fromitem.index > -1
      value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business

    str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value
    value = ""

    if e.toitem.index > -1
      _value = e.toitem.value
      value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business

    str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value
    $("#searchResultPanel").html str

  # 鼠标点击下拉列表后的事件

  myValue = ""

  ac.addEventListener "onconfirm", (e) ->
    _value = e.item.value

    myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business

    $("#searchResultPanel").html "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue
