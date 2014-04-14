class AddDepartment < Mongoid::Migration
  def self.up
  	other = Institution.create(name: "其他机构",description: "其他机构",sort: 999)
  	other.departments.create(name: "未知单位",description: "未知单位",sort: 999)
  	tju = Institution.create(name: "天津大学",description: "天津大学",sort: 0)
  	tju.departments.create(name: "图书馆",description: "图书馆",sort: 0)
  	tju.departments.create(name: "机械学院",description: "机械学院",sort: 1)
  	tju.departments.create(name: "精密仪器与光电子学院",description: "精密仪器与光电子学院",sort: 2)
  	tju.departments.create(name: "自动化学院",description: "自动化学院",sort: 3)
  	tju.departments.create(name: "经管学部",description: "经管学部",sort: 4)
  	
  end

  def self.down
  	Institution.delete_all()
  end
end