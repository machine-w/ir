class AddPropertyType < Mongoid::Migration
  def self.up
  	#substr=PropertyOper.new(name: "子字符串",description: "提取字符串的前n个字符",function_name: "subStr",function_context: " ")
  	str = PropertyType.create(name: "字符串",type_view: "string", image_path: "icon-font",user_can_select: true)
  	str.property_opers.create!(name: "子字符串",description: "提取字符串的前n个字符",function_name: "subStr",function_context: "tmp1")
	txt=PropertyType.create(name: "大文本",type_view: "text", image_path: "icon-text-height",user_can_select: true)
	txt.property_opers.create!(name: "子字符串",description: "提取字符串的前n个字符",function_name: "subStr",function_context: "tmp1")
	PropertyType.create(name: "整数",type_view: "integer", image_path: "icon-circle-blank",user_can_select: true)
	PropertyType.create(name: "实数",type_view: "number", image_path: " icon-circle",user_can_select: true)
	PropertyType.create(name: "嵌入式文档",type_view: "embed_html", image_path: "icon-copy",user_can_select: true)
	PropertyType.create(name: "单项选择",type_view: "enum", image_path: "icon-list-ul",user_can_select: true)
	PropertyType.create(name: "多项选择",type_view: "muli_enum", image_path: "icon-th-list",user_can_select: true)
	PropertyType.create(name: "PDF文档",type_view: "pdf", image_path: "icon-file-alt",user_can_select: true)
	PropertyType.create(name: "图片",type_view: "picture", image_path: "icon-picture",user_can_select: true)
	PropertyType.create(name: "视频",type_view: "video", image_path: "icon-facetime-video",user_can_select: true)
	PropertyType.create(name: "音乐",type_view: "music", image_path: "icon-music",user_can_select: true)
	PropertyType.create(name: "文件",type_view: "file", image_path: "icon-file",user_can_select: true)
	PropertyType.create(name: "日期",type_view: "date", image_path: "icon-calendar",user_can_select: true)
	PropertyType.create(name: "时间",type_view: "time", image_path: "icon-time",user_can_select: true)
	PropertyType.create(name: "数据表",type_view: "data_sheet", image_path: "icon-table",user_can_select: true)
	PropertyType.create(name: "列表",type_view: "array", image_path: "icon-list",user_can_select: true)
	PropertyType.create(name: "电子邮件",type_view: "email", image_path: "icon-envelope-alt",user_can_select: true)
	PropertyType.create(name: "链接",type_view: "link", image_path: "icon-link",user_can_select: true)
	PropertyType.create(name: "是否",type_view: "bool", image_path: "icon-ok",user_can_select: true)
  end

  def self.down
  	PropertyType.delete_all()
  end
end