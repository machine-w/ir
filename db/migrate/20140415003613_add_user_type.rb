class AddUserType < Mongoid::Migration
  def self.up
  	UserType.create(name: "教师", image_path: "professor",user_can_select: true)
	UserType.create(name: "本科生", image_path: "undergraduate",user_can_select: true)
	UserType.create(name: "研究生", image_path: "postgraduate",user_can_select: true)
	UserType.create(name: "研究人员", image_path: "research",user_can_select: true)
	UserType.create(name: "校外人士", image_path: "other",user_can_select: true)
	UserType.create(name: "公共账户", image_path: "public",user_can_select: true)
	UserType.create(name: "服务账户", image_path: "service",user_can_select: true)
  end

  def self.down
  	UserType.delete_all()
  end
end