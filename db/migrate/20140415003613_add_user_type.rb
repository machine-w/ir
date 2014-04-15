class AddUserType < Mongoid::Migration
  def self.up
  	UserType.create(name: "教师", image_path: "fa-credit-card",user_can_select: true)
	UserType.create(name: "本科生", image_path: "fa-book",user_can_select: true)
	UserType.create(name: "研究生", image_path: "fa-th-large",user_can_select: true)
	UserType.create(name: "研究人员", image_path: "fa-video-camera",user_can_select: true)
	UserType.create(name: "校外人士", image_path: "fa-home",user_can_select: true)
	UserType.create(name: "公共账户", image_path: "fa-lightbulb-o",user_can_select: true)
	UserType.create(name: "服务账户", image_path: "fa-picture-o",user_can_select: true)
  end

  def self.down
  	UserType.delete_all()
  end
end