class AddPropertyType < Mongoid::Migration
  def self.up
  	#substr=PropertyOper.new(name: "子字符串",description: "提取字符串的前n个字符",function_name: "subStr",function_context: " ")
  	str = PropertyType.create(name: "字符串",type_view: "string", image_path: "fa-font",user_can_select: true)
  	#str.property_opers.create!(name: "子字符串",description: "提取字符串的前n个字符",function_name: "subStr",function_context: "tmp1")
	txt=PropertyType.create(name: "大文本",type_view: "text", image_path: "fa-text-height",user_can_select: true)
	#txt.property_opers.create!(name: "子字符串",description: "提取字符串的前n个字符",function_name: "subStr",function_context: "tmp1")
	PropertyType.create(name: "整数",type_view: "integer", image_path: "fa-circle-o",user_can_select: true)
	PropertyType.create(name: "实数",type_view: "number", image_path: " fa-circle",user_can_select: true)
	PropertyType.create(name: "嵌入式文档",type_view: "embed_html", image_path: "fa-copy",user_can_select: true)
	PropertyType.create(name: "单项选择",type_view: "enum", image_path: "fa-list-ul",user_can_select: true)
	PropertyType.create(name: "多项选择",type_view: "muli_enum", image_path: "fa-th-list",user_can_select: true)
	PropertyType.create(name: "PDF文档",type_view: "pdf", image_path: "fa-file-text",user_can_select: true)
	PropertyType.create(name: "图片",type_view: "picture", image_path: "fa-picture-o",user_can_select: true)
	PropertyType.create(name: "视频",type_view: "video", image_path: "fa-video-camera",user_can_select: true)
	PropertyType.create(name: "音乐",type_view: "music", image_path: "fa-music",user_can_select: true)
	PropertyType.create(name: "文件",type_view: "file", image_path: "fa-file",user_can_select: true)
	PropertyType.create(name: "日期",type_view: "date", image_path: "fa-calendar",user_can_select: true)
	PropertyType.create(name: "时间",type_view: "time", image_path: "fa-clock-o",user_can_select: true)
	PropertyType.create(name: "数据表",type_view: "data_sheet", image_path: "fa-table",user_can_select: true)
	PropertyType.create(name: "列表",type_view: "array", image_path: "fa-ellipsis-h",user_can_select: true)
	PropertyType.create(name: "电子邮件",type_view: "email", image_path: "fa-envelope-o",user_can_select: true)
	PropertyType.create(name: "链接",type_view: "link", image_path: "fa-link",user_can_select: true)
	PropertyType.create(name: "是否",type_view: "bool", image_path: "fa-check",user_can_select: true)
  end

  def self.down
  	PropertyType.delete_all()
  end
end