class AddUserType < Mongoid::Migration
  def self.up
  	UserType.create(name: "教师", image_path: "fa-male",user_can_select: true)
	UserType.create(name: "本科生", image_path: "fa-maxcdn",user_can_select: true)
	UserType.create(name: "研究生", image_path: "fa-css3",user_can_select: true)
	UserType.create(name: "研究人员", image_path: "fa-flask",user_can_select: true)
	UserType.create(name: "校外人士", image_path: "fa-user",user_can_select: true)
	UserType.create(name: "公共账户", image_path: "fa-renren",user_can_select: true)
	UserType.create(name: "服务账户", image_path: "fa-android",user_can_select: true)
  end

  def self.down
  	UserType.delete_all()
  end
end