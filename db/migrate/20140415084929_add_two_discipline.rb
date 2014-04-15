class AddTwoDiscipline < Mongoid::Migration
  def self.up
  	zhexue= FirstDiscipline.find_by(code: '01')
  	zhexue.second_disciplines.create(name: "哲学",code: "0101",description: "哲学",sort: 1)
  	jingji= FirstDiscipline.find_by(code: '02')
  	jingji.second_disciplines.create(name: "理论经济学",code: "0201",description: "理论经济学",sort: 1)
    jingji.second_disciplines.create(name: "应用经济学",code: "0202",description: "应用经济学",sort: 2)
  end

  def self.down
  	ThirdDiscipline.delete_all()
  end
end