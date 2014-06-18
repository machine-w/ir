class AddThreeDiscipline < Mongoid::Migration
  def self.up
    zhexue= SecondDiscipline.find_by(code: '0101')
    zhexue.third_disciplines.create(name: "马克思主义哲学",code: "010101",description: "马克思主义哲学",sort: 1)
    zhexue.third_disciplines.create(name: "中国哲学",code: "010102",description: "中国哲学",sort: 2)
    zhexue.third_disciplines.create(name: "外国哲学",code: "010103",description: "外国哲学",sort: 3)
    zhexue.third_disciplines.create(name: "逻辑学",code: "010104",description: "逻辑学",sort: 4)
    zhexue.third_disciplines.create(name: "伦理学",code: "010105",description: "伦理学",sort: 5)
    zhexue.third_disciplines.create(name: "美学",code: "010106",description: "美学",sort: 6)
    zhexue.third_disciplines.create(name: "宗教学",code: "010107",description: "宗教学",sort: 7)
    zhexue.third_disciplines.create(name: "科学技术哲学",code: "010108",description: "科学技术哲学",sort: 8)



    lilunjingji= SecondDiscipline.find_by(code: '0201')
    lilunjingji.third_disciplines.create(name: "政治经济学",code: "020101",description: "政治经济学",sort: 1)
  lilunjingji.third_disciplines.create(name: "经济思想史",code: "020102",description: "经济思想史",sort: 2)
    lilunjingji.third_disciplines.create(name: "经济史",code: "020103",description: "经济史",sort: 3)
    lilunjingji.third_disciplines.create(name: "西方经济学",code: "020104",description: "西方经济学",sort: 4)
    lilunjingji.third_disciplines.create(name: "世界经济学",code: "020105",description: "世界经济学",sort: 5)
    lilunjingji.third_disciplines.create(name: "人口、资源与环境经济学",code: "020106",description: "人口、资源与环境经济学",sort: 6)


  yingyongjingji = SecondDiscipline.find_by(code: '0202')
  yingyongjingji.third_disciplines.create(name: "国民经济学",code: "020201",description: "国民经济学",sort: 1)
  yingyongjingji.third_disciplines.create(name: "区域经济学",code: "020202",description: "区域经济学",sort: 2)
    yingyongjingji.third_disciplines.create(name: "财政学",code:"020203",description:"财政学",sort: 3)
    yingyongjingji.third_disciplines.create(name: "金融学",code:"020204",description:"金融学",sort: 4)
    yingyongjingji.third_disciplines.create(name: "产业经济学",code:"020205",description:"产业经济学",sort: 5)
    yingyongjingji.third_disciplines.create(name: "国际贸易学",code:"020206",description:"国际贸易学",sort: 6)
    yingyongjingji.third_disciplines.create(name: "劳动经济学",code:"020207",description:"劳动经济学",sort: 7)
    yingyongjingji.third_disciplines.create(name: "统计学",code:"020208",description:"统计学",sort: 8)
    yingyongjingji.third_disciplines.create(name: "数量经济学",code:"020209",description:"数量经济学",sort: 9)
    yingyongjingji.third_disciplines.create(name: "国防经济",code:"020210",description:"国防经济",sort: 10)



    faxue = SecondDiscipline.find_by(code: '0301')
    faxue.third_disciplines.create(name:"法学理论",code:"030101",description:"法学理论",sort:1)
    faxue.third_disciplines.create(name:"法律史",code:"030102",description:"法律史",sort:2)
    faxue.third_disciplines.create(name:"宪法学与行政法学",code:"030103",description:"宪法学与行政法学",sort:3)
    faxue.third_disciplines.create(name:"刑法学",code:"030104",description:"刑法学",sort:4)
    faxue.third_disciplines.create(name:"民商法学",code:"030105",description:"民商法学",sort:5)
    faxue.third_disciplines.create(name:"诉讼法学",code:"030106",description:"诉讼法学",sort:6)
    faxue.third_disciplines.create(name:"经济法学",code:"030107",description:"经济法学",sort:7)
    faxue.third_disciplines.create(name:"环境与资源保护法学",code:"030108",description:"环境与资源保护法学",sort:8)
    faxue.third_disciplines.create(name:"国际法学",code:"030109",description:"国际法学",sort:9)
    faxue.third_disciplines.create(name:"军事法学",code:"030110",description:"军事法学",sort:10)

    
    zhengzhixue = SecondDiscipline.find_by(code: '0302')
    zhengzhixue.third_disciplines.create(name: "政治学理论",code: "030201",description: "政治学理论",sort: 1)
    zhengzhixue.third_disciplines.create(name: "中外政治制度",code: "030202",description: "中外政治制度",sort: 2)
    zhengzhixue.third_disciplines.create(name: "科学社会主义与国际共产主义运动",code: "030203",description: "科学社会主义与国际共产主义运动",sort: 3)
    zhengzhixue.third_disciplines.create(name: "中共党史",code: "030204",description: "中共党史",sort: 4)
    zhengzhixue.third_disciplines.create(name: "马克思主义理论与思想政治教育",code: "030205",description: "马克思主义理论与思想政治教育",sort: 5)
    zhengzhixue.third_disciplines.create(name: "国际政治",code: "030206",description: "国际政治",sort: 6)
    zhengzhixue.third_disciplines.create(name: "国际关系",code: "030207",description: "国际关系",sort: 7)
    zhengzhixue.third_disciplines.create(name: "外交学",code: "030208",description: "外交学",sort: 8)

    shehuixue = SecondDiscipline.find_by(code: '0303')
    shehuixue.third_disciplines.create(name: "社会学",code: "030301",description: "社会学",sort: 1)
    shehuixue.third_disciplines.create(name: "人口学",code: "030302",description: "人口学",sort: 2)
    shehuixue.third_disciplines.create(name: "人类学",code: "030303",description: "人类学",sort: 3)
    shehuixue.third_disciplines.create(name: "民俗学",code: "030304",description: "民俗学",sort: 4)

    minzuxue = SecondDiscipline.find_by(code: '0304')
    minzuxue.third_disciplines.create(name: "民族学",code: "030401",description: "民族学",sort: 1)
    minzuxue.third_disciplines.create(name: "马克思主义民族理论与政策",code: "030402",description: "马克思主义民族理论与政策",sort: 2)
    minzuxue.third_disciplines.create(name: "中国少数民族经济",code: "030403",description: "中国少数民族经济",sort: 3)
    minzuxue.third_disciplines.create(name: "中国少数民族史",code: "030404",description: "中国少数民族史",sort: 4)
    minzuxue.third_disciplines.create(name: "中国少数民族艺术",code: "030405",description: "中国少数民族艺术",sort: 5)


    jiaoyuxue = SecondDiscipline.find_by(code: '0401')
    jiaoyuxue.third_disciplines.create(name: "教育学原理",code: "040101",description: "教育学原理",sort: 1)
    jiaoyuxue.third_disciplines.create(name: "课程与教学论",code: "040102",description: "课程与教学论",sort: 2)
    jiaoyuxue.third_disciplines.create(name: "教育史",code: "040103",description: "教育史",sort: 3)
    jiaoyuxue.third_disciplines.create(name: "比较教育学",code: "040104",description: "比较教育学",sort: 4)
    jiaoyuxue.third_disciplines.create(name: "学前教育学",code: "040105",description: "学前教育学",sort: 5)
    jiaoyuxue.third_disciplines.create(name: "高等教育学",code: "040106",description: "高等教育学",sort: 6)
    jiaoyuxue.third_disciplines.create(name: "成人教育学",code: "040107",description: "成人教育学",sort: 7)
    jiaoyuxue.third_disciplines.create(name: "职业技术教育学",code: "040108",description: "职业技术教育学",sort: 8)
    jiaoyuxue.third_disciplines.create(name: "特殊教育学",code: "040109",description: "特殊教育学",sort: 9)
    jiaoyuxue.third_disciplines.create(name: "教育技术学",code: "040110",description: "教育技术学",sort: 10)


    xinlixue = SecondDiscipline.find_by(code: '0402')
    xinlixue.third_disciplines.create(name: "基础心理学",code: "040201",description: "基础心理学",sort: 1)
    xinlixue.third_disciplines.create(name: "发展与教育心理学",code: "040202",description: "发展与教育心理学",sort: 2)
    xinlixue.third_disciplines.create(name: "应用心理学",code: "040203",description: "应用心理学",sort: 3)


    tiyuxue = SecondDiscipline.find_by(code: '0403')
    tiyuxue.third_disciplines.create(name: "体育人文社会学",code: "040301",description: "体育人文社会学",sort: 1)
    tiyuxue.third_disciplines.create(name: "运动人体科学",code: "040302",description: "运动人体科学",sort: 2)
    tiyuxue.third_disciplines.create(name: "体育教育训练学",code: "040303",description: "体育教育训练学",sort: 3)
    tiyuxue.third_disciplines.create(name: "民族传统体育学",code: "040304",description: "民族传统体育学",sort: 4)



    zhongguoyuyan = SecondDiscipline.find_by(code: '0501')
    zhongguoyuyan.third_disciplines.create(name: "文艺学",code: "050101",description: "文艺学",sort: 1)
    zhongguoyuyan.third_disciplines.create(name: "语言学及应用语言学",code: "050102",description: "语言学及应用语言学",sort: 2)
    zhongguoyuyan.third_disciplines.create(name: "汉语言文字学",code: "050103",description: "汉语言文字学",sort: 3)
    zhongguoyuyan.third_disciplines.create(name: "中国古典文献学",code: "050104",description: "中国古典文献学",sort: 4)
    zhongguoyuyan.third_disciplines.create(name: "中国古代文学",code: "050105",description: "中国古代文学",sort: 5)
    zhongguoyuyan.third_disciplines.create(name: "中国现当代文学",code: "050106",description: "中国现当代文学",sort: 6)
    zhongguoyuyan.third_disciplines.create(name: "中国少数民族语言文学",code: "050107",description: "中国少数民族语言文学",sort: 7)
    zhongguoyuyan.third_disciplines.create(name: "比较文学与世界文学",code: "050108",description: "比较文学与世界文学",sort: 8)

    waiguoyuyan = SecondDiscipline.find_by(code: '0502')
    waiguoyuyan.third_disciplines.create(name: "英语语言文学",code: "050201",description: "英语语言文学",sort: 1)
    waiguoyuyan.third_disciplines.create(name: "俄语语言文学",code: "050202",description: "俄语语言文学",sort: 2)
    waiguoyuyan.third_disciplines.create(name: "法语语言文学",code: "050203",description: "法语语言文学",sort: 3)
    waiguoyuyan.third_disciplines.create(name: "德语语言文学",code: "050204",description: "德语语言文学",sort: 4)
    waiguoyuyan.third_disciplines.create(name: "日语语言文学",code: "050205",description: "日语语言文学",sort: 5)
    waiguoyuyan.third_disciplines.create(name: "印度语言文学",code: "050206",description: "印度语言文学",sort: 6)
    waiguoyuyan.third_disciplines.create(name: "西班牙语语言文学",code: "050207",description: "西班牙语语言文学",sort: 7)
    waiguoyuyan.third_disciplines.create(name: "阿拉伯语语言文学",code: "050208",description: "阿拉伯语语言文学",sort: 8)
    waiguoyuyan.third_disciplines.create(name: "欧洲语言文学",code: "050209",description: "欧洲语言文学",sort: 9)
    waiguoyuyan.third_disciplines.create(name: "亚非语言文学",code: "050210",description: "亚非语言文学",sort: 10)
    waiguoyuyan.third_disciplines.create(name: "外国语言学及应用语言学",code: "050211",description: "外国语言学及应用语言学",sort: 11)


    xinwenchuanbo = SecondDiscipline.find_by(code: '0503')
    xinwenchuanbo.third_disciplines.create(name: "新闻学",code: "050301",description: "新闻学",sort: 1)
    xinwenchuanbo.third_disciplines.create(name: "传播学",code: "050302",description: "传播学",sort: 2)


    yishuxue = SecondDiscipline.find_by(code: '0504')
    yishuxue.third_disciplines.create(name: "艺术学",code: "050401",description: "艺术学",sort: 1)
    yishuxue.third_disciplines.create(name: "音乐学",code: "050402",description: "音乐学",sort: 2)
    yishuxue.third_disciplines.create(name: "美术学",code: "050403",description: "美术学",sort: 3)
    yishuxue.third_disciplines.create(name: "设计艺术学",code: "050404",description: "设计艺术学",sort: 4)
    yishuxue.third_disciplines.create(name: "戏剧戏曲学",code: "050405",description: "戏剧戏曲学",sort: 5)
    yishuxue.third_disciplines.create(name: "电影学",code: "050406",description: "电影学",sort: 6)
    yishuxue.third_disciplines.create(name: "广播电视艺术学",code: "050407",description: "广播电视艺术学",sort: 7)
    yishuxue.third_disciplines.create(name: "舞蹈学",code: "050408",description: "舞蹈学",sort: 8)



    lishixue = SecondDiscipline.find_by(code: '0601')
    lishixue.third_disciplines.create(name: "史学理论及史学史",code: "060101",description: "史学理论及史学史",sort: 1)
    lishixue.third_disciplines.create(name: "考古学及博物馆学",code: "060102",description: "考古学及博物馆学",sort: 2)
    lishixue.third_disciplines.create(name: "历史地理学",code: "060103",description: "历史地理学",sort: 3)
    lishixue.third_disciplines.create(name: "历史文献学",code: "060104",description: "历史文献学",sort: 4)
    lishixue.third_disciplines.create(name: "专门史",code: "060105",description: "专门史",sort: 5)
    lishixue.third_disciplines.create(name: "中国古代史",code: "060106",description: "中国古代史",sort: 6)
    lishixue.third_disciplines.create(name: "中国近现代史",code: "060107",description: "中国近现代史",sort: 7)
    lishixue.third_disciplines.create(name: "世界史",code: "060108",description: "世界史",sort: 8)



    lixue = SecondDiscipline.find_by(code: '0701')
    lixue.third_disciplines.create(name: "基础数学",code: "070101",description: "基础数学",sort: 1)
    lixue.third_disciplines.create(name: "计算数学",code: "070102",description: "计算数学",sort: 2)
    lixue.third_disciplines.create(name: "概率论与数理统计",code: "070103",description: "概率论与数理统计",sort: 3)
    lixue.third_disciplines.create(name: "应用数学",code: "070104",description: "应用数学",sort: 4)
    lixue.third_disciplines.create(name: "运筹学与控制论",code: "070105",description: "运筹学与控制论",sort: 5)
    
    
    wulixue = SecondDiscipline.find_by(code: '0702')
    wulixue.third_disciplines.create(name: "理论物理",code: "070201",description: "理论物理",sort: 1)
    wulixue.third_disciplines.create(name: "粒子物理与原子核物理",code: "070202",description: "粒子物理与原子核物理",sort: 2)
    wulixue.third_disciplines.create(name: "原子与分子物理",code: "070203",description: "原子与分子物理",sort: 3)
    wulixue.third_disciplines.create(name: "等离子体物理",code: "070204",description: "等离子体物理",sort: 4)
    wulixue.third_disciplines.create(name: "凝聚态物理",code: "070205",description: "凝聚态物理",sort: 5)
    wulixue.third_disciplines.create(name: "声学",code: "070206",description: "声学",sort: 6)
    wulixue.third_disciplines.create(name: "光学",code: "070207",description: "光学",sort: 7)
    wulixue.third_disciplines.create(name: "无线电物理",code: "070208",description: "无线电物理",sort: 8)

    huaxue = SecondDiscipline.find_by(code: '0703')
    huaxue.third_disciplines.create(name: "无机化学",code: "070301",description: "无机化学",sort: 1)
    huaxue.third_disciplines.create(name: "分析化学",code: "070302",description: "分析化学",sort: 2)
    huaxue.third_disciplines.create(name: "有机化学",code: "070303",description: "有机化学",sort: 3)
    huaxue.third_disciplines.create(name: "物理化学",code: "070304",description: "物理化学",sort: 4)
    huaxue.third_disciplines.create(name: "高分子化学与物理",code: "070305",description: "高分子化学与物理",sort: 5)


    tianwenxue = SecondDiscipline.find_by(code: '0704')
    tianwenxue.third_disciplines.create(name: "天体物理",code: "070401",description: "天体物理",sort: 1)
    tianwenxue.third_disciplines.create(name: "天体测量与天体力学",code: "070402",description: "天体测量与天体力学",sort: 2)


    dilixue = SecondDiscipline.find_by(code: '0705')
    dilixue.third_disciplines.create(name: "自然地理学",code: "070501",description: "自然地理学",sort: 1)
    dilixue.third_disciplines.create(name: "人文地理学",code: "070502",description: "人文地理学",sort: 2)
    dilixue.third_disciplines.create(name: "地图学与地理信息系统",code: "070503",description: "地图学与地理信息系统",sort: 3)


    daqikexue = SecondDiscipline.find_by(code: '0706')
    daqikexue.third_disciplines.create(name: "气象学",code: "070601",description: "气象学",sort: 1)
    daqikexue.third_disciplines.create(name: "大气物理学与大气环境",code: "070602",description: "大气物理学与大气环境",sort: 2)


    haiyangkexue = SecondDiscipline.find_by(code: '0707')
    haiyangkexue.third_disciplines.create(name: "物理海洋学",code: "070701",description: "物理海洋学",sort: 1)
    haiyangkexue.third_disciplines.create(name: "海洋化学",code: "070702",description: "海洋化学",sort: 2)
    haiyangkexue.third_disciplines.create(name: "海洋生物学",code: "070703",description: "海洋生物学",sort: 3)
    haiyangkexue.third_disciplines.create(name: "海洋地质",code: "070704",description: "海洋地质",sort: 4)


    diqiuwulixue = SecondDiscipline.find_by(code: '0708')
    diqiuwulixue.third_disciplines.create(name: "固体地球物理学",code: "070801",description: "固体地球物理学",sort: 1)
    diqiuwulixue.third_disciplines.create(name: "空间物理学",code: "070802",description: "空间物理学",sort: 2)


    dizhixue = SecondDiscipline.find_by(code: '0709')
    dizhixue.third_disciplines.create(name: "矿物学、岩石学、矿床学",code: "070901",description: "矿物学、岩石学、矿床学",sort: 1)
    dizhixue.third_disciplines.create(name: "地球化学",code: "070902",description: "地球化学",sort: 2)
    dizhixue.third_disciplines.create(name: "古生物学与地层学",code: "070903",description: "古生物学与地层学",sort: 3)
    dizhixue.third_disciplines.create(name: "构造地质学",code: "070904",description: "构造地质学",sort: 4)
    dizhixue.third_disciplines.create(name: "第四纪地质学",code: "070905",description: "第四纪地质学",sort: 5)


    shengwuxue = SecondDiscipline.find_by(code: '0710')
    shengwuxue.third_disciplines.create(name: "植物学",code: "071001",description: "植物学",sort: 1)
    shengwuxue.third_disciplines.create(name: "动物学",code: "071002",description: "动物学",sort: 2)
    shengwuxue.third_disciplines.create(name: "生理学",code: "071003",description: "生理学",sort: 3)
    shengwuxue.third_disciplines.create(name: "水生生物学",code: "071004",description: "水生生物学",sort: 4)
    shengwuxue.third_disciplines.create(name: "微生物学",code: "071005",description: "微生物学",sort: 5)
    shengwuxue.third_disciplines.create(name: "神经生物学",code: "071006",description: "神经生物学",sort: 6)
    shengwuxue.third_disciplines.create(name: "遗传学",code: "071007",description: "遗传学",sort: 7)
    shengwuxue.third_disciplines.create(name: "发育生物学",code: "071008",description: "发育生物学",sort: 8)
    shengwuxue.third_disciplines.create(name: "细胞生物学",code: "071009",description: "细胞生物学",sort: 9)
    shengwuxue.third_disciplines.create(name: "生物化学与分子生物学",code: "071010",description: "生物化学与分子生物学",sort: 10)
    shengwuxue.third_disciplines.create(name: "生物物理学",code: "071011",description: "生物物理学",sort: 11)
    shengwuxue.third_disciplines.create(name: "生态学",code: "071012",description: "生态学",sort: 12)


    xitongkexue = SecondDiscipline.find_by(code: '0711')
    xitongkexue.third_disciplines.create(name: "系统理论",code: "071101",description: "系统理论",sort: 1)
    xitongkexue.third_disciplines.create(name: "系统分析与集成",code: "071102",description: "系统分析与集成",sort: 2)


    mechanics = SecondDiscipline.find_by(code: '0801')
    mechanics.third_disciplines.create(name: "一般力学与力学基础",code: "080101",description: "一般力学与力学基础",sort: 1)
    mechanics.third_disciplines.create(name: "固体力学",code: "080102",description: "固体力学",sort: 2)
    mechanics.third_disciplines.create(name: "流体力学",code: "080103",description: "流体力学",sort: 3)
    mechanics.third_disciplines.create(name: "工程力学",code: "080104",description: "工程力学",sort: 4)


    jixiegongcheng = SecondDiscipline.find_by(code: '0802')
    jixiegongcheng.third_disciplines.create(name: "机械制造及其自动化",code: "080201",description: "机械制造及其自动化",sort: 1)
    jixiegongcheng.third_disciplines.create(name: "机械电子工程",code: "080202",description: "机械电子工程",sort: 2)
    jixiegongcheng.third_disciplines.create(name: "机械设计及理论",code: "080203",description: "机械设计及理论",sort: 3)
    jixiegongcheng.third_disciplines.create(name: "车辆工程",code: "080204",description: "车辆工程",sort: 4)


    yiqikexueyujishu = SecondDiscipline.find_by(code: '0804')
    yiqikexueyujishu.third_disciplines.create(name: "精密仪器及机械",code: "080401",description: "精密仪器及机械",sort: 1)
    yiqikexueyujishu.third_disciplines.create(name: "测试计量技术及仪器",code: "080402",description: "测试计量技术及仪器",sort: 2)


    cailiaokexueyugongcheng = SecondDiscipline.find_by(code: '0805')
    cailiaokexueyugongcheng.third_disciplines.create(name: "材料物理与化学",code: "080501",description: "材料物理与化学",sort: 1)
    cailiaokexueyugongcheng.third_disciplines.create(name: "材料学",code: "080502",description: "材料学",sort: 2)
    cailiaokexueyugongcheng.third_disciplines.create(name: "材料加工工程",code: "080503",description: "材料加工工程",sort: 3)


    yejingongcheng = SecondDiscipline.find_by(code: '0806')
    yejingongcheng.third_disciplines.create(name: "冶金物理化学",code: "080601",description: "冶金物理化学",sort: 1)
    yejingongcheng.third_disciplines.create(name: "钢铁冶金",code: "080602",description: "钢铁冶金",sort: 2)
    yejingongcheng.third_disciplines.create(name: "有色金属冶金",code: "080603",description: "有色金属冶金",sort: 3)


    dongligongcheng = SecondDiscipline.find_by(code: '0807')
    dongligongcheng.third_disciplines.create(name: "工程热物理",code: "080701",description: "工程热物理",sort: 1)
    dongligongcheng.third_disciplines.create(name: "热能工程",code: "080702",description: "热能工程",sort: 2)
    dongligongcheng.third_disciplines.create(name: "动力机械及工程",code: "080703",description: "动力机械及工程",sort: 3)
    dongligongcheng.third_disciplines.create(name: "流体机械及工程",code: "080704",description: "流体机械及工程",sort: 4)
    dongligongcheng.third_disciplines.create(name: "制冷及低温工程",code: "080705",description: "制冷及低温工程",sort: 5)
    dongligongcheng.third_disciplines.create(name: "化工过程机械",code: "080706",description: "化工过程机械",sort: 6)


    dianqigongcheng = SecondDiscipline.find_by(code: '0808')
    dianqigongcheng.third_disciplines.create(name: "电机与电器",code: "080801",description: "电机与电器",sort: 1)
    dianqigongcheng.third_disciplines.create(name: "电力系统及其自动化",code: "080802",description: "电力系统及其自动化",sort: 2)
    dianqigongcheng.third_disciplines.create(name: "高电压与绝缘技术",code: "080803",description: "高电压与绝缘技术",sort: 3)
    dianqigongcheng.third_disciplines.create(name: "电力电子与电力传动",code: "080804",description: "电力电子与电力传动",sort: 4)
    dianqigongcheng.third_disciplines.create(name: "电工理论与新技术",code: "080805",description: "电工理论与新技术",sort: 5)


    dianzikexue = SecondDiscipline.find_by(code: '0809')
    dianzikexue.third_disciplines.create(name: "物理电子学",code: "080901",description: "物理电子学",sort: 1)
    dianzikexue.third_disciplines.create(name: "电路与系统",code: "080902",description: "电路与系统",sort: 2)
    dianzikexue.third_disciplines.create(name: "微电子学与固体电子学",code: "080903",description: "微电子学与固体电子学",sort: 3)
    dianzikexue.third_disciplines.create(name: "电磁场与微波技术",code: "080904",description: "电磁场与微波技术",sort: 4)


    xinxiyuxinxigongcheng = SecondDiscipline.find_by(code: '0810')
    xinxiyuxinxigongcheng.third_disciplines.create(name: "通信与信息系统",code: "081001",description: "通信与信息系统",sort: 1)
    xinxiyuxinxigongcheng.third_disciplines.create(name: "信号与信息处理",code: "081002",description: "信号与信息处理",sort: 2)


    kongzhikexue = SecondDiscipline.find_by(code: '0811')
    kongzhikexue.third_disciplines.create(name: "控制理论与控制工程",code: "081101",description: "控制理论与控制工程",sort: 1)
    kongzhikexue.third_disciplines.create(name: "检测技术与自动化装置",code: "081102",description: "检测技术与自动化装置",sort: 2)
    kongzhikexue.third_disciplines.create(name: "系统工程",code: "081103",description: "系统工程",sort: 3)
    kongzhikexue.third_disciplines.create(name: "模式识别与智能系统",code: "081104",description: "模式识别与智能系统",sort: 4)
    kongzhikexue.third_disciplines.create(name: "导航、制导与控制",code: "081105",description: "导航、制导与控制",sort: 5)


    jisuanjikexue = SecondDiscipline.find_by(code: '0812')
    jisuanjikexue.third_disciplines.create(name: "计算机系统结构",code: "081201",description: "计算机系统结构",sort: 1)
    jisuanjikexue.third_disciplines.create(name: "计算机软件与理论",code: "081202",description: "计算机软件与理论",sort: 2)
    jisuanjikexue.third_disciplines.create(name: "计算机应用技术",code: "081203",description: "计算机应用技术",sort: 3)


    jianzhuxue = SecondDiscipline.find_by(code: '0813')
    jianzhuxue.third_disciplines.create(name: "建筑历史与理论",code: "081301",description: "建筑历史与理论",sort: 1)
    jianzhuxue.third_disciplines.create(name: "建筑设计与其理论",code: "081302",description: "建筑设计与其理论",sort: 2)
    jianzhuxue.third_disciplines.create(name: "城市规划与设计",code: "081303",description: "城市规划与设计",sort: 3)
    jianzhuxue.third_disciplines.create(name: "建筑技术科学",code: "081304",description: "建筑技术科学",sort: 4)


    tumugongcheng = SecondDiscipline.find_by(code: '0814')
    tumugongcheng.third_disciplines.create(name: "岩土工程",code: "081401",description: "岩土工程",sort: 1)
    tumugongcheng.third_disciplines.create(name: "结构工程",code: "081402",description: "结构工程",sort: 2)
    tumugongcheng.third_disciplines.create(name: "市政工程",code: "081403",description: "市政工程",sort: 3)
    tumugongcheng.third_disciplines.create(name: "供热、供燃气、通风及空调工程",code: "081404",description: "供热、供燃气、通风及空调工程",sort: 4)
    tumugongcheng.third_disciplines.create(name: "防灾减灾工程及防护工程",code: "081405",description: "防灾减灾工程及防护工程",sort: 5)
    tumugongcheng.third_disciplines.create(name: "桥梁与隧道工程",code: "081406",description: "桥梁与隧道工程",sort: 6)


    shuiligongcheng = SecondDiscipline.find_by(code: '0815')
    shuiligongcheng.third_disciplines.create(name: "水文学及水资源",code: "081501",description: "水文学及水资源",sort: 1)
    shuiligongcheng.third_disciplines.create(name: "水力学及河流动力学",code: "081502",description: "水力学及河流动力学",sort: 2)
    shuiligongcheng.third_disciplines.create(name: "水工结构工程",code: "081503",description: "水工结构工程",sort: 3)
    shuiligongcheng.third_disciplines.create(name: "水利水电工程",code: "081504",description: "水利水电工程",sort: 4)
    shuiligongcheng.third_disciplines.create(name: "港口、海岸及近海工程",code: "081505",description: "港口、海岸及近海工程",sort: 5)


    cehuikexue = SecondDiscipline.find_by(code: '0816')
    cehuikexue.third_disciplines.create(name: "大地测量学与测量工程",code: "081601",description: "大地测量学与测量工程",sort: 1)
    cehuikexue.third_disciplines.create(name: "摄影测量与遥感",code: "081602",description: "摄影测量与遥感",sort: 2)
    cehuikexue.third_disciplines.create(name: "地图制图学与地理信息工程",code: "081603",description: "地图制图学与地理信息工程",sort: 3)


    huaxuegongcheng = SecondDiscipline.find_by(code: '0817')
    huaxuegongcheng.third_disciplines.create(name: "化学工程",code: "081701",description: "化学工程",sort: 1)
    huaxuegongcheng.third_disciplines.create(name: "化学工艺",code: "081702",description: "化学工艺",sort: 2)
    huaxuegongcheng.third_disciplines.create(name: "生物化工",code: "081703",description: "生物化工",sort: 3)
    huaxuegongcheng.third_disciplines.create(name: "应用化学",code: "081704",description: "应用化学",sort: 4)
    huaxuegongcheng.third_disciplines.create(name: "工业催化",code: "081705",description: "工业催化",sort: 5)


    dizhiziyuanyugongcheng = SecondDiscipline.find_by(code: '0818')
    dizhiziyuanyugongcheng.third_disciplines.create(name: "矿产普查与勘探",code: "081801",description: "矿产普查与勘探",sort: 1)
    dizhiziyuanyugongcheng.third_disciplines.create(name: "地球探测与信息技术",code: "081802",description: "地球探测与信息技术",sort: 2)
    dizhiziyuanyugongcheng.third_disciplines.create(name: "地质工程",code: "081803",description: "地质工程",sort: 3)


    kuangyegongcheng = SecondDiscipline.find_by(code: '0819')
    kuangyegongcheng.third_disciplines.create(name: "采矿工程",code: "081901",description: "采矿工程",sort: 1)
    kuangyegongcheng.third_disciplines.create(name: "矿物加工工程",code: "081902",description: "矿物加工工程",sort: 2)
    kuangyegongcheng.third_disciplines.create(name: "完全技术及工程",code: "081903",description: "完全技术及工程",sort: 3)


    shiyouyutianranqi = SecondDiscipline.find_by(code: '0820')
    shiyouyutianranqi.third_disciplines.create(name: "油气井工程",code: "082001",description: "油气井工程",sort: 1)
    shiyouyutianranqi.third_disciplines.create(name: "油气田开发工程",code: "082002",description: "油气田开发工程",sort: 2)
    shiyouyutianranqi.third_disciplines.create(name: "油气储运工程",code: "082003",description: "油气储运工程",sort: 3)


    fangzhikexue = SecondDiscipline.find_by(code: '0821')
    fangzhikexue.third_disciplines.create(name: "纺织工程",code: "082101",description: "纺织工程",sort: 1)
    fangzhikexue.third_disciplines.create(name: "纺织材料与纺织品设计",code: "082102",description: "纺织材料与纺织品设计",sort: 2)
    fangzhikexue.third_disciplines.create(name: "纺织化学与染整工程",code: "082103",description: "纺织化学与染整工程",sort: 3)
    fangzhikexue.third_disciplines.create(name: "服装",code: "082104",description: "服装",sort: 4)


    qinggongjishu = SecondDiscipline.find_by(code: '0822')
    qinggongjishu.third_disciplines.create(name: "制浆造纸工程",code: "082201",description: "制浆造纸工程",sort: 1)
    qinggongjishu.third_disciplines.create(name: "制糖工程",code: "082202",description: "制糖工程",sort: 2)
    qinggongjishu.third_disciplines.create(name: "发酵工程",code: "082203",description: "发酵工程",sort: 3)
    qinggongjishu.third_disciplines.create(name: "皮革化学与工程",code: "082204",description: "皮革化学与工程",sort: 4)


    jiaotongyunshu = SecondDiscipline.find_by(code: '0823')
    jiaotongyunshu.third_disciplines.create(name: "道路与铁道工程",code: "082301",description: "道路与铁道工程",sort: 1)
    jiaotongyunshu.third_disciplines.create(name: "交通信息工程及控制",code: "082302",description: "交通信息工程及控制",sort: 2)
    jiaotongyunshu.third_disciplines.create(name: "交通运输规划与管理",code: "082303",description: "交通运输规划与管理",sort: 3)
    jiaotongyunshu.third_disciplines.create(name: "载运工具运用工程",code: "082304",description: "载运工具运用工程",sort: 4)


    chuanboyuhaiyang = SecondDiscipline.find_by(code: '0824')
    chuanboyuhaiyang.third_disciplines.create(name: "船舶与海洋结构物设计制造",code: "082401",description: "船舶与海洋结构物设计制造",sort: 1)
    chuanboyuhaiyang.third_disciplines.create(name: "轮机工程",code: "082402",description: "轮机工程",sort: 2)
    chuanboyuhaiyang.third_disciplines.create(name: "水声工程",code: "082403",description: "水声工程",sort: 3)


    hangkongyuhangkexue = SecondDiscipline.find_by(code: '0825')
    hangkongyuhangkexue.third_disciplines.create(name: "飞行器设计",code: "082501",description: "飞行器设计",sort: 1)
    hangkongyuhangkexue.third_disciplines.create(name: "航空宇航推进理论与工程",code: "082502",description: "航空宇航推进理论与工程",sort: 2)
    hangkongyuhangkexue.third_disciplines.create(name: "航空宇航制造工程",code: "082503",description: "航空宇航制造工程",sort: 3)
    hangkongyuhangkexue.third_disciplines.create(name: "人机与环境工程",code: "082504",description: "人机与环境工程",sort: 4)


    bingqikexue = SecondDiscipline.find_by(code: '0826')
    bingqikexue.third_disciplines.create(name: "武器系统与运用工程",code: "082601",description: "武器系统与运用工程",sort: 1)
    bingqikexue.third_disciplines.create(name: "兵器发射理论与技术",code: "082602",description: "兵器发射理论与技术",sort: 2)
    bingqikexue.third_disciplines.create(name: "火炮、自动武器与弹药工程",code: "082603",description: "火炮、自动武器与弹药工程",sort: 3)
    bingqikexue.third_disciplines.create(name: "军事化学与烟火技术",code: "082604",description: "军事化学与烟火技术",sort: 4)


    hekexue = SecondDiscipline.find_by(code: '0827')
    hekexue.third_disciplines.create(name: "核能科学与工程",code: "082701",description: "核能科学与工程",sort: 1)
    hekexue.third_disciplines.create(name: "核燃料循环与材料",code: "082702",description: "核燃料循环与材料",sort: 2)
    hekexue.third_disciplines.create(name: "核技术及应用",code: "082703",description: "核技术及应用",sort: 3)
    hekexue.third_disciplines.create(name: "辐射防护及环境保护",code: "082704",description: "辐射防护及环境保护",sort: 4)


    nongyegongcheng = SecondDiscipline.find_by(code: '0828')
    nongyegongcheng.third_disciplines.create(name: "农业机械化工程",code: "082801",description: "农业机械化工程",sort: 1)
    nongyegongcheng.third_disciplines.create(name: "农业水土工程",code: "082802",description: "农业水土工程",sort: 2)
    nongyegongcheng.third_disciplines.create(name: "农业生物环境与能源工程",code: "082803",description: "农业生物环境与能源工程",sort: 3)
    nongyegongcheng.third_disciplines.create(name: "农业电气化与自动化",code: "082804",description: "农业电气化与自动化",sort: 4)


    linyegongcheng = SecondDiscipline.find_by(code: '0829')
    linyegongcheng.third_disciplines.create(name: "森林工程",code: "082901",description: "森林工程",sort: 1)
    linyegongcheng.third_disciplines.create(name: "木材科学与技术",code: "082902",description: "木材科学与技术",sort: 2)
    linyegongcheng.third_disciplines.create(name: "林产化学加工工程",code: "082903",description: "林产化学加工工程",sort: 3)


    huanjingkexue = SecondDiscipline.find_by(code: '0830')
    huanjingkexue.third_disciplines.create(name: "环境科学",code: "083001",description: "环境科学",sort: 1)
    huanjingkexue.third_disciplines.create(name: "环境工程",code: "083002",description: "环境工程",sort: 2)


    shipinkexue = SecondDiscipline.find_by(code: '0832')
    shipinkexue.third_disciplines.create(name: "食品科学",code: "083201",description: "食品科学",sort: 1)
    shipinkexue.third_disciplines.create(name: "粮食、油脂及植物蛋白工程",code: "083202",description: "粮食、油脂及植物蛋白工程",sort: 2)
    shipinkexue.third_disciplines.create(name: "农产品加工及贮藏工程",code: "083203",description: "农产品加工及贮藏工程",sort: 3)
    shipinkexue.third_disciplines.create(name: "产品加工及贮藏工程",code: "083204",description: "产品加工及贮藏工程",sort: 4)



    zuowu= SecondDiscipline.find_by(code: '0901')
    zuowu.third_disciplines.create(name: "作物栽培学与耕作学",code: "090101",description: "作物栽培学与耕作学",sort: 1)
    zuowu.third_disciplines.create(name: "作物遗传育种",code: "090102",description: "作物遗传育种",sort: 2)
    
    yuanyi= SecondDiscipline.find_by(code: '0902')
    yuanyi.third_disciplines.create(name: "果树学",code: "090201",description: "果树学",sort: 1)
    yuanyi.third_disciplines.create(name: "蔬菜学",code: "090202",description: "蔬菜学",sort: 2)
    yuanyi.third_disciplines.create(name: "茶学",code: "090203",description: "茶学",sort: 3)
    
    nongyeziyuan= SecondDiscipline.find_by(code: '0903')
    nongyeziyuan.third_disciplines.create(name: "土壤学",code: "090301",description: "土壤学",sort: 1)
    nongyeziyuan.third_disciplines.create(name: "植物营养学",code: "090302",description: "植物营养学",sort: 2)
    
    zhiwubaohu= SecondDiscipline.find_by(code: '0904')
    zhiwubaohu.third_disciplines.create(name: "植物病理学",code: "090401",description: "植物病理学",sort: 1)
    zhiwubaohu.third_disciplines.create(name: "农业昆虫与害虫防治",code: "090402",description: "农业昆虫与害虫防治",sort: 2)
    zhiwubaohu.third_disciplines.create(name: "农药学",code: "090403",description: "农药学",sort: 3)
    
    xumu= SecondDiscipline.find_by(code: '0905')
    xumu.third_disciplines.create(name: "动物遗传育种与繁殖",code: "090501",description: "动物遗传育种与繁殖",sort: 1)
    xumu.third_disciplines.create(name: "动物营养与饲料科学",code: "090502",description: "动物营养与饲料科学",sort: 2)
    xumu.third_disciplines.create(name: "草业科学",code: "090503",description: "草业科学",sort: 3)
    xumu.third_disciplines.create(name: "特种经济动物饲养",code: "090504",description: "特种经济动物饲养",sort: 4)
    
    shouyi= SecondDiscipline.find_by(code: '0906')
    shouyi.third_disciplines.create(name: "基础兽医学",code: "090601",description: "基础兽医学",sort: 1)
    shouyi.third_disciplines.create(name: "预防兽医学",code: "090602",description: "预防兽医学",sort: 2)
    shouyi.third_disciplines.create(name: "临床兽医学",code: "090603",description: "临床兽医学",sort: 3)
    
    linxue= SecondDiscipline.find_by(code: '0907')
    linxue.third_disciplines.create(name: "林木遗传育种",code: "090701",description: "林木遗传育种",sort: 1)
    linxue.third_disciplines.create(name: "森林培育",code: "090702",description: "森林培育",sort: 2)
    linxue.third_disciplines.create(name: "森林保护学",code: "090703",description: "森林保护学",sort: 3)
    linxue.third_disciplines.create(name: "森林经理学",code: "090704",description: "森林经理学",sort: 4)
    linxue.third_disciplines.create(name: "野生动植物保护与利用",code: "090705",description: "野生动植物保护与利用",sort: 5)
    linxue.third_disciplines.create(name: "园林植物与观赏园艺",code: "090706",description: "园林植物与观赏园艺",sort: 6)
    linxue.third_disciplines.create(name: "水土保持与荒漠化防治",code: "090707",description: "水土保持与荒漠化防治",sort: 7)
    
    shuichan= SecondDiscipline.find_by(code: '0908')
    shuichan.third_disciplines.create(name: "水产养殖",code: "090801",description: "水产养殖",sort: 1)
    shuichan.third_disciplines.create(name: "捕捞学",code: "090802",description: "捕捞学",sort: 2)
    shuichan.third_disciplines.create(name: "渔业资源",code: "090803",description: "渔业资源",sort: 3)
    


    jichuyixue= SecondDiscipline.find_by(code: '1001')
    jichuyixue.third_disciplines.create(name: "人体解剖与组织胚胎学",code: "0100101",description: "人体解剖与组织胚胎学",sort: 1)
    jichuyixue.third_disciplines.create(name: "免疫学",code: "0100102",description: "免疫学",sort: 2)
    jichuyixue.third_disciplines.create(name: "病原生物学",code: "0100103",description: "病原生物学",sort: 3)
    jichuyixue.third_disciplines.create(name: "病理学与病理生物学",code: "0100104",description: "病理学与病理生物学",sort: 4)
    jichuyixue.third_disciplines.create(name: "法医学",code: "0100105",description: "法医学",sort: 5)
    jichuyixue.third_disciplines.create(name: "放射医学",code: "0100106",description: "放射医学",sort: 6)
    jichuyixue.third_disciplines.create(name: "航空、航天与航海医学",code: "0100107",description: "航空、航天与航海医学",sort: 7)
    
    linchuangyixue= SecondDiscipline.find_by(code: '1002')
    linchuangyixue.third_disciplines.create(name: "内科学（心血管病）",code: "0100201",description: "内科学（心血管病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（血液病）",code: "0100201",description: "内科学（血液病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（呼吸系病）",code: "0100201",description: "内科学（呼吸系病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（消化系病）",code: "0100201",description: "内科学（消化系病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（内分泌与代谢病）",code: "0100201",description: "内科学（内分泌与代谢病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（肾病）",code: "0100201",description: "内科学（肾病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（风湿病）",code: "0100201",description: "内科学（风湿病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "内科学（传染病）",code: "0100201",description: "内科学（传染病）",sort: 1)
    linchuangyixue.third_disciplines.create(name: "儿科学",code: "0100202",description: "儿科学",sort: 2)
    linchuangyixue.third_disciplines.create(name: "老年医学",code: "0100203",description: "老年医学",sort: 3)
    linchuangyixue.third_disciplines.create(name: "神经病学",code: "0100204",description: "神经病学",sort: 4)
    linchuangyixue.third_disciplines.create(name: "精神病与精神卫生学",code: "0100205",description: "精神病与精神卫生学",sort: 5)
    linchuangyixue.third_disciplines.create(name: "皮肤病与性病学",code: "0100206",description: "皮肤病与性病学",sort: 6)
    linchuangyixue.third_disciplines.create(name: "影像医学与核医学",code: "0100207",description: "影像医学与核医学",sort: 7)
    linchuangyixue.third_disciplines.create(name: "临床检验诊断学",code: "0100208",description: "临床检验诊断学",sort: 8)
    linchuangyixue.third_disciplines.create(name: "护理学",code: "0100209",description: "护理学",sort: 9)
    linchuangyixue.third_disciplines.create(name: "外科学（普外）",code: "0100210",description: "外科学（普外）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（骨外）",code: "0100210",description: "外科学（骨外）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（泌尿外）",code: "0100210",description: "外科学（泌尿外）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（胸心外）",code: "0100210",description: "外科学（胸心外）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（神外）",code: "0100210",description: "外科学（神外）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（整形）",code: "0100210",description: "外科学（整形）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（烧伤）",code: "0100210",description: "外科学（烧伤）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "外科学（野战外）",code: "0100210",description: "外科学（野战外）",sort: 10)
    linchuangyixue.third_disciplines.create(name: "妇产科学",code: "0100211",description: "妇产科学",sort: 11)
    linchuangyixue.third_disciplines.create(name: "眼科学",code: "0100212",description: "眼科学",sort: 12)
    linchuangyixue.third_disciplines.create(name: "耳鼻咽喉科学",code: "0100213",description: "耳鼻咽喉科学",sort: 13)
    linchuangyixue.third_disciplines.create(name: "肿瘤学",code: "0100214",description: "肿瘤学",sort: 14)
    linchuangyixue.third_disciplines.create(name: "康复医学与理疗学",code: "0100215",description: "康复医学与理疗学",sort: 15)
    linchuangyixue.third_disciplines.create(name: "运动医学",code: "0100216",description: "运动医学",sort: 16)
    linchuangyixue.third_disciplines.create(name: "麻醉学",code: "0100217",description: "麻醉学",sort: 17)
    linchuangyixue.third_disciplines.create(name: "急诊医学",code: "0100218",description: "急诊医学",sort: 18)
    
    kouqiangyixue= SecondDiscipline.find_by(code: '1003')
    kouqiangyixue.third_disciplines.create(name: "口腔基础医学",code: "0100301",description: "口腔基础医学",sort: 1)
    kouqiangyixue.third_disciplines.create(name: "口腔临床医学",code: "0100302",description: "口腔临床医学",sort: 2)
    
    gonggongweisheng= SecondDiscipline.find_by(code: '1003')
    gonggongweisheng.third_disciplines.create(name: "流行病与卫生统计学",code: "0100401",description: "流行病与卫生统计学",sort: 1)
    gonggongweisheng.third_disciplines.create(name: "劳动卫生与环境卫生学",code: "0100402",description: "劳动卫生与环境卫生学",sort: 2)
    gonggongweisheng.third_disciplines.create(name: "营养与食品卫生学",code: "0100403",description: "营养与食品卫生学",sort: 3)
    gonggongweisheng.third_disciplines.create(name: "儿少卫生与妇幼保健学",code: "0100404",description: "儿少卫生与妇幼保健学",sort: 4)
    gonggongweisheng.third_disciplines.create(name: "卫生毒理学",code: "0100405",description: "卫生毒理学",sort: 5)
    gonggongweisheng.third_disciplines.create(name: "军事预防医学",code: "0100406",description: "军事预防医学",sort: 6)
    
    zhongyi= SecondDiscipline.find_by(code: '1005')
    zhongyi.third_disciplines.create(name: "中医基础理论",code: "0100501",description: "中医基础理论",sort: 1)
    zhongyi.third_disciplines.create(name: "中医临床基础",code: "0100502",description: "中医临床基础",sort: 2)
    zhongyi.third_disciplines.create(name: "中医医史文献",code: "0100503",description: "中医医史文献",sort: 3)
    zhongyi.third_disciplines.create(name: "方剂学",code: "0100504",description: "方剂学",sort: 4)
    zhongyi.third_disciplines.create(name: "中医诊断学",code: "0100505",description: "中医诊断学",sort: 5)
    zhongyi.third_disciplines.create(name: "中医内科学",code: "0100506",description: "中医内科学",sort: 6)
    zhongyi.third_disciplines.create(name: "中医外科学",code: "0100507",description: "中医外科学",sort: 7)
    zhongyi.third_disciplines.create(name: "中医骨伤科学",code: "0100508",description: "中医骨伤科学",sort: 8)
    zhongyi.third_disciplines.create(name: "中医妇科学",code: "0100509",description: "中医妇科学",sort: 9)
    zhongyi.third_disciplines.create(name: "中医儿科学",code: "0100510",description: "中医儿科学",sort: 10)
    zhongyi.third_disciplines.create(name: "中医五官科学",code: "0100511",description: "中医五官科学",sort: 11)
    zhongyi.third_disciplines.create(name: "针灸推拿学",code: "0100512",description: "针灸推拿学",sort: 12)
    
    zhongxiyi= SecondDiscipline.find_by(code: '1006')
    zhongxiyi.third_disciplines.create(name: "中西医结合基础",code: "0100601",description: "中西医结合基础",sort: 1)
    zhongxiyi.third_disciplines.create(name: "中西医结合临床",code: "0100602",description: "中西医结合临床",sort: 2)
    
    yaoxue= SecondDiscipline.find_by(code: '1007')
    yaoxue.third_disciplines.create(name: "药物化学",code: "0100701",description: "药物化学",sort: 1)
    yaoxue.third_disciplines.create(name: "药剂学",code: "0100702",description: "药剂学",sort: 2)
    yaoxue.third_disciplines.create(name: "生药学",code: "0100703",description: "生药学",sort: 3)
    yaoxue.third_disciplines.create(name: "药物分析学",code: "0100704",description: "药物分析学",sort: 4)
    yaoxue.third_disciplines.create(name: "微生物与生化药学",code: "0100705",description: "微生物与生化药学",sort: 5)
    yaoxue.third_disciplines.create(name: "药理学",code: "0100706",description: "药理学",sort: 6)




    junshisixiang= SecondDiscipline.find_by(code: '1101')
    junshisixiang.third_disciplines.create(name: "军事思想",code: "0110101",description: "军事思想",sort: 1)
    junshisixiang.third_disciplines.create(name: "军事历史",code: "0110102",description: "军事历史",sort: 2)
    
    zhanlve= SecondDiscipline.find_by(code: '1102')
    zhanlve.third_disciplines.create(name: "军事战略学",code: "0110201",description: "军事战略学",sort: 1)
    zhanlve.third_disciplines.create(name: "战争动员学",code: "0110202",description: "战争动员学",sort: 2)
    
    zhanyi= SecondDiscipline.find_by(code: '1103')
    zhanyi.third_disciplines.create(name: "联合战役学",code: "0110301",description: "联合战役学",sort: 1)
    zhanyi.third_disciplines.create(name: "军种战役学",code: "0110302",description: "军种战役学",sort: 2)
    
    zhanshu= SecondDiscipline.find_by(code: '1104')
    zhanshu.third_disciplines.create(name: "合同战术学",code: "0110401",description: "合同战术学",sort: 1)
    zhanshu.third_disciplines.create(name: "兵种战术学",code: "0110402",description: "兵种战术学",sort: 2)
    
    junduizhihui= SecondDiscipline.find_by(code: '1105')
    junduizhihui.third_disciplines.create(name: "作战指挥学",code: "0110501",description: "作战指挥学",sort: 1)
    junduizhihui.third_disciplines.create(name: "军事运筹学",code: "0110502",description: "军事运筹学",sort: 2)
    junduizhihui.third_disciplines.create(name: "军事通信学",code: "0110503",description: "军事通信学",sort: 3)
    junduizhihui.third_disciplines.create(name: "军事情报学",code: "0110504",description: "军事情报学",sort: 4)
    junduizhihui.third_disciplines.create(name: "密码学",code: "0110505",description: "密码学",sort: 5)
    junduizhihui.third_disciplines.create(name: "军事教育训练学",code: "0110506",description: "军事教育训练学",sort: 6)
    
    junzhi= SecondDiscipline.find_by(code: '1106')
    junzhi.third_disciplines.create(name: "军事组织编制学",code: "0110601",description: "军事组织编制学",sort: 1)
    junzhi.third_disciplines.create(name: "军队管理学",code: "0110602",description: "军队管理学",sort: 2)
    
    junshihouqin= SecondDiscipline.find_by(code: '1108')
    junshihouqin.third_disciplines.create(name: "军事后勤学",code: "0110801",description: "军事后勤学",sort: 1)
    junshihouqin.third_disciplines.create(name: "后方专业勤务",code: "0110802",description: "后方专业勤务",sort: 2)
    junshihouqin.third_disciplines.create(name: "军事装备学",code: "0110803",description: "军事装备学",sort: 3)



    gongshangguanli= SecondDiscipline.find_by(code: '1202')
    gongshangguanli.third_disciplines.create(name: "会计学",code: "0120201",description: "会计学",sort: 1)
    gongshangguanli.third_disciplines.create(name: "企业管理",code: "0120202",description: "企业管理",sort: 2)
    gongshangguanli.third_disciplines.create(name: "旅游管理",code: "0120203",description: "旅游管理",sort: 3)
    gongshangguanli.third_disciplines.create(name: "技术经济及管理",code: "0120204",description: "技术经济及管理",sort: 4)
    
    nonglinjingji= SecondDiscipline.find_by(code: '1203')
    nonglinjingji.third_disciplines.create(name: "农业经济管理",code: "0120301",description: "农业经济管理",sort: 1)
    nonglinjingji.third_disciplines.create(name: "林业经济管理",code: "0120302",description: "林业经济管理",sort: 2)
    
    gonggongguanli= SecondDiscipline.find_by(code: '1204')
    gonggongguanli.third_disciplines.create(name: "行政管理",code: "0120401",description: "行政管理",sort: 1)
    gonggongguanli.third_disciplines.create(name: "社会医学与卫生事业管理",code: "0120402",description: "社会医学与卫生事业管理",sort: 2)
    gonggongguanli.third_disciplines.create(name: "教育经济与管理",code: "0120403",description: "教育经济与管理",sort: 3)
    gonggongguanli.third_disciplines.create(name: "社会保障",code: "0120404",description: "社会保障",sort: 4)
    gonggongguanli.third_disciplines.create(name: "土地资源管理",code: "0120405",description: "土地资源管理",sort: 5)
    
    tuqingdangan= SecondDiscipline.find_by(code: '1205')
    tuqingdangan.third_disciplines.create(name: "图书馆学",code: "0120501",description: "图书馆学",sort: 1)
    tuqingdangan.third_disciplines.create(name: "情报学",code: "0120502",description: "情报学",sort: 2)
    tuqingdangan.third_disciplines.create(name: "档案学",code: "0120503",description: "档案学",sort: 3)
  end

  def self.down
  	ThirdDiscipline.delete_all()
  end
end