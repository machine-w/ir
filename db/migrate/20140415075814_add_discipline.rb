class AddDiscipline < Mongoid::Migration
  def self.up
  	zhexue = FirstDiscipline.create(name: "哲学",code: "01",description: "哲学",sort: 1)
  		# zhexue2 = zhexue.second_disciplines.create(name: "哲学",code: "0101",description: "哲学",sort: 1)
		  # 	zhexue2.third_disciplines.create(name: "马克思主义哲学",code: "010101",description: "马克思主义哲学",sort: 1)
		  # 	zhexue2.third_disciplines.create(name: "中国哲学",code: "010102",description: "中国哲学",sort: 2)
  	jingjixue = FirstDiscipline.create(name: "经济学",code: "02",description: "经济学",sort: 2)
  # 		lilunjingjixue = jingjixue.second_disciplines.create(name: "理论经济学",code: "0201",description: "理论经济学",sort: 1)
  # 			lilunjingjixue.third_disciplines.create(name: "政治经济学",code: "020101",description: "政治经济学",sort: 1)
		#   	lilunjingjixue.third_disciplines.create(name: "经济思想史",code: "020102",description: "经济思想史",sort: 2)
		# yingyongjingjixue = jingjixue.second_disciplines.create(name: "应用经济学",code: "0202",description: "应用经济学",sort: 2)
  # 			yingyongjingjixue.third_disciplines.create(name: "国民经济学",code: "020201",description: "国民经济学",sort: 1)
		#   	yingyongjingjixue.third_disciplines.create(name: "区域经济学",code: "020202",description: "区域经济学",sort: 2)
  end

  def self.down
  	FirstDiscipline.delete_all()
  end
end