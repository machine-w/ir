class AddThreeDiscipline < Mongoid::Migration
  def self.up
  	zhexue= SecondDiscipline.find_by(code: '0101')
  	zhexue.third_disciplines.create(name: "马克思主义哲学",code: "010101",description: "马克思主义哲学",sort: 1)
  	lilunjingji= SecondDiscipline.find_by(code: '0201')
  	lilunjingji.third_disciplines.create(name: "政治经济学",code: "020101",description: "政治经济学",sort: 1)
	lilunjingji.third_disciplines.create(name: "经济思想史",code: "020102",description: "经济思想史",sort: 2)
	yingyongjingji = SecondDiscipline.find_by(code: '0202')
	yingyongjingji.third_disciplines.create(name: "国民经济学",code: "020201",description: "国民经济学",sort: 1)
	yingyongjingji.third_disciplines.create(name: "区域经济学",code: "020202",description: "区域经济学",sort: 2)
  end

  def self.down
  	ThirdDiscipline.delete_all()
  end
end