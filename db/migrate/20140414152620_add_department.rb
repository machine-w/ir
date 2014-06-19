class AddDepartment < Mongoid::Migration
  def self.up
  	other = Institution.create(name: "其他机构",description: "其他机构",sort: 999)
    other.departments.create(name: "未知单位",description: "未知单位",sort: 999)

    tju = Institution.create(name: "天津大学",description: "天津大学",sort: 0)
    tju.departments.create(name: "图书馆",description: "图书馆",sort: 0)
    tju.departments.create(name: "机械工程学院",description: "机械工程学院",sort: 1)
    tju.departments.create(name: "精密仪器与光电子学院",description: "精密仪器与光电子学院",sort: 2)
    tju.departments.create(name: "管理与经济学部",description: "管理与经济学部",sort: 9)
    tju.departments.create(name: "电子信息工程学院",description: "电子信息工程学院",sort: 4)
    tju.departments.create(name: "电气与自动化工程学院",description: "电气与自动化工程学院",sort: 3)
    tju.departments.create(name: "建筑工程学院",description: "建筑工程学院",sort: 5)
    tju.departments.create(name: "化工学院",description: "化工学院",sort: 7)
    tju.departments.create(name: "材料科学与工程学院",description: "材料科学与工程学院",sort: 8)
    tju.departments.create(name: "建筑学院",description: "建筑学院",sort: 6)
    tju.departments.create(name: "求是学部",description: "求是学部",sort: 21)
    tju.departments.create(name: "理学院",description: "理学院",sort: 10)
    tju.departments.create(name: "文法学院",description: "文法学院",sort: 11)
    tju.departments.create(name: "软件学院",description: "软件学院",sort: 18)
    tju.departments.create(name: "计算机科学与技术学院",description: "计算机科学与技术学院",sort: 16)
    tju.departments.create(name: "教育学院",description: "教育学院",sort: 12)
    tju.departments.create(name: "药物科学与技术学院",description: "药物科学与技术学院",sort: 13)
    tju.departments.create(name: "环境科学与工程学院",description: "环境科学与工程学院",sort: 14)
    tju.departments.create(name: "马克思主义学院",description: "马克思主义学院",sort: 15)
    tju.departments.create(name: "生命科学学院",description: "生命科学学院",sort: 20)
    tju.departments.create(name: "职业技术教育学院",description: "职业技术教育学院",sort: 22)
    tju.departments.create(name: "继续教育学院",description: "继续教育学院",sort: 23)
    tju.departments.create(name: "科研院",description: "科研院",sort: 31)
    tju.departments.create(name: "研究生院",description: "研究生院",sort: 32)
    tju.departments.create(name: "教务处",description: "教务处",sort: 33)
  	
  end

  def self.down
    Department.delete_all()
  	Institution.delete_all()
  end
end