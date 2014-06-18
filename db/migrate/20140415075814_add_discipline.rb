class AddDiscipline < Mongoid::Migration
  def self.up
    zhexue = FirstDiscipline.create(name: "哲学",code: "01",description: "哲学",sort: 1)
    jingjixue = FirstDiscipline.create(name: "经济学",code: "02",description: "经济学",sort: 2)
    faxue = FirstDiscipline.create(name: "法学",code: "03",description: "法学",sort: 3)
    jiaoyuxue = FirstDiscipline.create(name: "教育学",code: "04",description: "教育学",sort: 4)
    wenxue = FirstDiscipline.create(name: "文学",code: "05",description: "文学",sort: 5)
    lishixue = FirstDiscipline.create(name: "历史学",code: "06",description: "历史学",sort: 6)
    lixue = FirstDiscipline.create(name: "理学",code: "07",description: "理学",sort: 7)
    gongxue = FirstDiscipline.create(name: "工学",code: "08",description: "工学",sort: 8)
    nongxue = FirstDiscipline.create(name: "农学",code: "09",description: "农学",sort: 9)
    yixue = FirstDiscipline.create(name: "医学",code: "10",description: "医学",sort: 10)
    junshixue = FirstDiscipline.create(name: "军事学",code: "11",description: "军事学",sort: 11)
    guanlixue = FirstDiscipline.create(name: "管理学",code: "12",description: "管理学",sort: 12)
    yishuxue = FirstDiscipline.create(name: "艺术学",code: "13",description: "艺术学",sort: 13)
  end

  def self.down
  	FirstDiscipline.delete_all()
  end
end