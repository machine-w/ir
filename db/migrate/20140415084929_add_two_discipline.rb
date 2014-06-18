class AddTwoDiscipline < Mongoid::Migration
  def self.up
    zhexue= FirstDiscipline.find_by(code: '01')
    zhexue.second_disciplines.create(name: "哲学",code: "0101",description: "哲学",sort: 1)
    
    jingji= FirstDiscipline.find_by(code: '02')
    jingji.second_disciplines.create(name: "理论经济学",code: "0201",description: "理论经济学",sort: 1)
    jingji.second_disciplines.create(name: "应用经济学",code: "0202",description: "应用经济学",sort: 2)

    faxue= FirstDiscipline.find_by(code: '03')
    faxue.second_disciplines.create(name: "法学", code:"0301", description:"法学", sort: 1)
    faxue.second_disciplines.create(name: "政治学", code:"0302", description:"政治学", sort: 2)
    faxue.second_disciplines.create(name: "社会学", code:"0303", description:"社会学", sort: 3)
    faxue.second_disciplines.create(name: "民族学", code:"0304", description:"民族学", sort: 4)

    jiaoyuxue= FirstDiscipline.find_by(code: '04')
    jiaoyuxue.second_disciplines.create(name: "教育学", code:"0401", description:"教育学", sort: 1)
    jiaoyuxue.second_disciplines.create(name: "心理学", code:"0402", description:"心理学", sort: 2)
    jiaoyuxue.second_disciplines.create(name: "体育学", code:"0403", description:"体育学", sort: 3)

    wenxue= FirstDiscipline.find_by(code: '05')
    wenxue.second_disciplines.create(name: "中国语言文学", code:"0501", description:"中国语言文学", sort: 1)
    wenxue.second_disciplines.create(name: "外国语言文学", code:"0502", description:"外国语言文学", sort: 2)
    wenxue.second_disciplines.create(name: "新闻传播学", code:"0503", description:"新闻传播学", sort: 3)
    wenxue.second_disciplines.create(name: "艺术学", code:"0504", description:"艺术学", sort: 4)

    lishixue= FirstDiscipline.find_by(code: '06')
    lishixue.second_disciplines.create(name: "历史学", code:"0601", description:"历史学", sort: 1)

    lixue= FirstDiscipline.find_by(code: '07')
    lixue.second_disciplines.create(name: "数学", code:"0701", description:"数学", sort: 1)
    lixue.second_disciplines.create(name: "物理学", code:"0702", description:"物理学", sort: 2)
    lixue.second_disciplines.create(name: "化学", code:"0703", description:"化学", sort: 3)
    lixue.second_disciplines.create(name: "天文学", code:"0704", description:"天文学", sort: 4)
    lixue.second_disciplines.create(name: "地理学", code:"0705", description:"地理学", sort: 5)
    lixue.second_disciplines.create(name: "大气科学", code:"0706", description:"大气科学", sort: 6)
    lixue.second_disciplines.create(name: "海洋科学", code:"0707", description:"海洋科学", sort: 7)
    lixue.second_disciplines.create(name: "地球物理学", code:"0708", description:"地球物理学", sort: 8)
    lixue.second_disciplines.create(name: "地质学", code:"0709", description:"地质学", sort: 9)
    lixue.second_disciplines.create(name: "生物学", code:"0710", description:"生物学", sort: 10)
    lixue.second_disciplines.create(name: "系统科学", code:"0711", description:"系统科学", sort: 11)


    gongxue= FirstDiscipline.find_by(code: '08')
    gongxue.second_disciplines.create(name: "力学", code:"0801", description:"力学", sort: 1)
    gongxue.second_disciplines.create(name: "机械工程", code:"0802", description:"机械工程", sort: 2)
    gongxue.second_disciplines.create(name: "仪器科学与技术", code:"0804", description:"仪器科学与技术", sort: 4)
    gongxue.second_disciplines.create(name: "材料科学与工程", code:"0805", description:"材料科学与工程", sort: 5)
    gongxue.second_disciplines.create(name: "冶金工程", code:"0806", description:"冶金工程", sort: 6)
    gongxue.second_disciplines.create(name: "动力工程及工程热物理", code:"0807", description:"动力工程及工程热物理", sort: 7)
    gongxue.second_disciplines.create(name: "电气工程", code:"0808", description:"电气工程", sort: 8)
    gongxue.second_disciplines.create(name: "电子科学与技术", code:"0809", description:"电子科学与技术", sort: 9)
    gongxue.second_disciplines.create(name: "信息与通信工程", code:"0810", description:"信息与通信工程", sort: 10)
    gongxue.second_disciplines.create(name: "控制科学与工程", code:"0811", description:"控制科学与工程", sort: 11)
    gongxue.second_disciplines.create(name: "计算机科学与技术", code:"0812", description:"计算机科学与技术", sort: 12)
    gongxue.second_disciplines.create(name: "建筑学", code:"0813", description:"建筑学", sort: 13)
    gongxue.second_disciplines.create(name: "土木工程", code:"0814", description:"土木工程", sort: 14)
    gongxue.second_disciplines.create(name: "水利工程", code:"0815", description:"水利工程", sort: 15)
    gongxue.second_disciplines.create(name: "测绘科学与技术", code:"0816", description:"测绘科学与技术", sort: 16)
    gongxue.second_disciplines.create(name: "化学工程与技术", code:"0817", description:"化学工程与技术", sort: 17)
    gongxue.second_disciplines.create(name: "地质资源与地质工程", code:"0818", description:"地质资源与地质工程", sort: 18)
    gongxue.second_disciplines.create(name: "矿业工程", code:"0819", description:"矿业工程", sort: 19)
    gongxue.second_disciplines.create(name: "石油与天然气工程", code:"0820", description:"石油与天然气工程", sort: 20)
    gongxue.second_disciplines.create(name: "纺织科学与工程", code:"0821", description:"纺织科学与工程", sort: 21)
    gongxue.second_disciplines.create(name: "轻工技术与工程", code:"0822", description:"轻工技术与工程", sort: 22)
    gongxue.second_disciplines.create(name: "交通运输工程", code:"0823", description:"交通运输工程", sort: 23)
    gongxue.second_disciplines.create(name: "船舶与海洋工程", code:"0824", description:"船舶与海洋工程", sort: 24)
    gongxue.second_disciplines.create(name: "航空宇航科学与技术", code:"0825", description:"航空宇航科学与技术", sort: 25)
    gongxue.second_disciplines.create(name: "兵器科学与技术", code:"0826", description:"兵器科学与技术", sort: 26)
    gongxue.second_disciplines.create(name: "核科学与技术", code:"0827", description:"核科学与技术", sort: 27)
    gongxue.second_disciplines.create(name: "农业工程", code:"0828", description:"农业工程", sort: 28)
    gongxue.second_disciplines.create(name: "林业工程", code:"0829", description:"林业工程", sort: 29)
    gongxue.second_disciplines.create(name: "环境科学与工程", code:"0830", description:"环境科学与工程", sort: 30)
    gongxue.second_disciplines.create(name: "食品科学与工程", code:"0832", description:"食品科学与工程", sort: 32)


    nongxue= FirstDiscipline.find_by(code: '09')
    nongxue.second_disciplines.create(name: "作物学", code:"0901", description:"作物学", sort: 1)
    nongxue.second_disciplines.create(name: "园艺学", code:"0902", description:"园艺学", sort: 2)
    nongxue.second_disciplines.create(name: "农业资源利用", code:"0903", description:"农业资源利用", sort: 3)
    nongxue.second_disciplines.create(name: "植物保护", code:"0904", description:"植物保护", sort: 4)
    nongxue.second_disciplines.create(name: "畜牧学", code:"0905", description:"畜牧学", sort: 5)
    nongxue.second_disciplines.create(name: "兽医学", code:"0906", description:"兽医学", sort: 6)
    nongxue.second_disciplines.create(name: "林学", code:"0907", description:"林学", sort: 7)
    nongxue.second_disciplines.create(name: "水产", code:"0908", description:" 水产", sort: 8)


    yixue= FirstDiscipline.find_by(code: '10')
    yixue.second_disciplines.create(name: "基础医学", code:"1001", description:"基础医学", sort: 1)
    yixue.second_disciplines.create(name: "临床医学", code:"1002", description:"临床医学", sort: 2)
    yixue.second_disciplines.create(name: "口腔医学", code:"1003", description:"口腔医学", sort: 3)
    yixue.second_disciplines.create(name: "公共卫生与预防医学", code:"1004", description:"公共卫生与预防医学", sort: 4)
    yixue.second_disciplines.create(name: "中医学", code:"1005", description:"中医学", sort: 5)
    yixue.second_disciplines.create(name: "中西医结合", code:"1006", description:"中西医结合", sort: 6)
    yixue.second_disciplines.create(name: "药学", code:"1007", description:"药学", sort: 7)
   

    junshi= FirstDiscipline.find_by(code: '11')
    junshi.second_disciplines.create(name: "军事思想及军事历史", code:"1101", description:"军事思想及军事历史", sort: 1)
    junshi.second_disciplines.create(name: "战略学", code:"1102", description:"战略学", sort: 2)
    junshi.second_disciplines.create(name: "战役学", code:"1103", description:"战役学", sort: 3)
    junshi.second_disciplines.create(name: "战术学", code:"1104", description:"战术学", sort: 4)
    junshi.second_disciplines.create(name: "军队指挥学", code:"1105", description:"军队指挥学", sort: 5)
    junshi.second_disciplines.create(name: "军制学", code:"1106", description:"军制学", sort: 6)
    junshi.second_disciplines.create(name: "军事后勤学与军事装备学", code:"1108", description:"军事后勤学与军事装备学", sort: 8)


    guanlixue= FirstDiscipline.find_by(code: '12')
    guanlixue.second_disciplines.create(name: "工商管理", code:"1202", description:"工商管理", sort: 2)
    guanlixue.second_disciplines.create(name: "农林经济管理", code:"1203", description:"农林经济管理", sort: 3)
    guanlixue.second_disciplines.create(name: "公共管理", code:"1204", description:"公共管理", sort: 4)
    guanlixue.second_disciplines.create(name: "图书馆、情报与档案管理", code:"1205", description:"图书馆、情报与档案管理", sort: 5)


    yishuxue= FirstDiscipline.find_by(code: '13')
    yishuxue.second_disciplines.create(name: "美术学", code:"1304", description:"美术学", sort: 4)
    yishuxue.second_disciplines.create(name: "设计学", code:"1305", description:"设计学", sort: 5)
    yishuxue.second_disciplines.create(name: "艺术硕士（专业学位）", code:"1351", description:"艺术硕士（专业学位）", sort: 51)
  end

  def self.down
  	SecondDiscipline.delete_all()
  end
end