jQuery ($) ->
  # use ``rake make_index`` to generate
  index =
    "安徽": ["合肥"]
    "北京": ["北京"]
    "福建": ["福清", "福州", "古田", "晋江", "龙岩", "莆田", "泉州", "三明", "武夷山", "厦门", "漳州"]
    "甘肃": ["兰州"]
    "广东": ["潮州", "东莞", "佛山", "高州", "广州", "河源", "化州", "惠州", "江门", "揭阳", "梅州", "普宁", "清远", "汕头", "汕尾", "韶关", "深圳", "信宜", "阳江", "云浮", "湛江", "肇庆", "中山", "珠海"]
    "广西": ["北海", "东兴", "贵港", "贺州市", "来宾", "柳州", "南宁", "钦州", "玉林"]
    "贵州": ["贵阳", "六盘水"]
    "河北": ["泊头", "邯郸", "河间", "黄骅", "青县", "枣强"]
    "河南": ["平顶山", "郑州"]
    "黑龙江": ["佳木斯市", "齐齐哈尔市", "双城"]
    "湖北": ["荆州", "十堰", "武汉", "武穴", "宜昌"]
    "湖南": ["长沙", "郴州", "怀化", "邵东", "湘潭", "益阳", "岳阳", "耒阳"]
    "吉林": ["延吉"]
    "江苏": ["常州", "连云港", "南京", "苏州", "无锡", "徐州", "扬州"]
    "江西": ["赣州", "吉安", "南昌", "萍乡", "新余", "宜春"]
    "辽宁": ["营口"]
    "内蒙古": ["鄂尔多斯"]
    "宁夏": ["银川"]
    "青海": ["西宁市"]
    "山东": ["济南"]
    "山西": ["长冶", "晋城", "临汾", "朔州", "太原"]
    "陕西": ["西安"]
    "上海": ["上海"]
    "四川": ["成都", "绵阳", "攀枝花"]
    "天津": ["天津"]
    "新疆": ["乌鲁木齐"]
    "云南": ["楚雄", "昆明", "瑞丽", "玉溪"]
    "重庆": ["重庆"]
  if window.hasOwnProperty('STORES_SRC') and !window.hasOwnProperty('STORES') and $('#stores').length > 0
    ifnone = $('#ifnone').clone();
    $.getScript STORES_SRC, ->
      $('#stores_count').html(window.STORES.length)
    $.each index, (a,b) ->
      $('#province').append('<option value="'+a+'">'+a+'</option>')
    $('#province').change ->
      $('#city option:not(:first)').remove()
      province = $('#province').val()
      if province.length > 0 and index.hasOwnProperty(province)
        $.each index[province], (a,b) ->
          $('#city').append('<option value="'+b+'">'+b+'</option>')
        if index[province].length == 1
          $('#city').val(index[province][0])
        $('#city').trigger('change')
      else
        $('#stores-list tbody').empty().append(ifnone)
        $('#stores_count').html(window.STORES.length)
    $('#city').change ->
      $('#stores-list tbody').empty()
      province = $('#province').val()
      city = $('#city').val()
      $.each window.STORES, (a,b) ->
        if (city.length > 0 and b[2] is city) or (city.length == 0 and b[1] is province)
          tr = $('<tr />')
          store_info = b.slice()
          link = store_info.splice(-3,1)[0]
          if store_info.splice(-1,1)[0] == true
            tr.addClass('highlight')
          $.each store_info, (c, d) ->
            if c == 0 and link.length > 0
              d = '<a href="' + link + '" target="_blank">' + d + '</a>'
            $('<td />', html: d).appendTo tr
          $('#stores-list tbody').append tr
      $('#stores_count').html($('#stores-list tbody tr').length)