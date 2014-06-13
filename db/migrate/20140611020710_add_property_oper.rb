class AddPropertyOper < Mongoid::Migration
  def self.up
  	str = PropertyType.where(type_view_cd: 1).first
  	txt = PropertyType.where(type_view_cd: 2).first
  	int = PropertyType.where(type_view_cd: 3).first
  	num = PropertyType.where(type_view_cd: 4).first
  	emb = PropertyType.where(type_view_cd: 5).first
  	enum = PropertyType.where(type_view_cd: 6).first
  	mul = PropertyType.where(type_view_cd: 7).first
  	file = PropertyType.where(type_view_cd: 8).first
  	pdf = PropertyType.where(type_view_cd: 9).first
  	pic = PropertyType.where(type_view_cd: 10).first
  	video = PropertyType.where(type_view_cd: 11).first
  	music = PropertyType.where(type_view_cd: 12).first
  	time = PropertyType.where(type_view_cd: 13).first
  	date = PropertyType.where(type_view_cd: 14).first
  	data = PropertyType.where(type_view_cd: 15).first
  	arr = PropertyType.where(type_view_cd: 16).first
  	email = PropertyType.where(type_view_cd: 17).first
  	link = PropertyType.where(type_view_cd: 18).first
  	bool = PropertyType.where(type_view_cd: 19).first
  	str.property_opers.create!(name: "长度",description: "获取字符串长度",function_name:"size",params: [],function_context: "property_oper = lambda{ |str| str.length.to_s}")
  	txt.property_opers.create!(name: "长度",description: "获取字符串长度",function_name:"size",params: [],function_context: "property_oper = lambda{ |str| str.length.to_s}")
  	enum.property_opers.create!(name: "长度",description: "获取字符串长度",function_name:"size",params: [],function_context: "property_oper = lambda{ |str| str.length.to_s}")
  	mul.property_opers.create!(name: "个数",description: "选取选项的个数",function_name:"size",params: [],function_context: "property_oper = lambda{ |array| array ? array.length.to_s : '0' }")
  	mul.property_opers.create!(name: "逗号分割",description: "逗号分割显示",function_name:"dou",params: [],function_context: "property_oper = lambda{ |array| array ? array.join(',') : ''}")
  	arr.property_opers.create!(name: "逗号分割",description: "逗号分割显示",function_name:"dou",params: [],function_context: "property_oper = lambda{ |array| array ? array.join(',') : ''} ")
  	arr.property_opers.create!(name: "元素个数",description: "元素的个数",function_name:"size",params: [],function_context: "property_oper = lambda{ |array| array ? array.length.to_s : '0' }")
  	bool.property_opers.create!(name: "yes/no",description: "yesno显示",function_name:"yesno",params: [],function_context: "property_oper = lambda{ |bool| bool ? 'yes' : 'no'}")
  	
    pic.property_opers.create!(name: "原始大小",description: "图片原始尺寸显示",function_name:"origin",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| ("<a href='"+file.to_s+"'><img src='"+file.to_s+"' title='"+name+"' alt='"+name+"没有显示' class='user-img'></a>").html_safe }})
  	pic.property_opers.create!(name: "小尺寸",description: "小尺寸显示",function_name:"small",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| ("<a href='"+file.to_s+"'><img src='"+file.to_s+"' title='"+name+"' alt='"+name+"没有显示' class='small-img'></a>").html_safe }})
  	pic.property_opers.create!(name: "中尺寸",description: "中等尺寸显示",function_name:"normal",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| ("<a href='"+file.to_s+"'><img src='"+file.to_s+"' title='"+name+"' alt='"+name+"没有显示' class='normal-img'></a>").html_safe }})
  	pic.property_opers.create!(name: "大尺寸",description: "大尺寸显示",function_name:"big",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| ("<a href='"+file.to_s+"'><img src='"+file.to_s+"' title='"+name+"' alt='"+name+"没有显示' class='big-img'></a>").html_safe }})
  	pic.property_opers.create!(name: "文件大小",description: "文件大小",function_name:"size",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| (size/1024).floor.to_s+'K' }})
  	
  	video.property_opers.create!(name: "原始播放",description: "嵌入视频播放",function_name:"origin",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| "<video src='"+file.to_s+"?random="+rand(999999).to_s+"' controls='controls' class='user-video'>你的浏览器不支持播放视频</video>" }})
  	video.property_opers.create!(name: "小尺寸播放",description: "嵌入视频播放",function_name:"small",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| "<video src='"+file.to_s+"?random="+rand(999999).to_s+"' controls='controls' class='small-video'>你的浏览器不支持播放视频</video>" }})
  	video.property_opers.create!(name: "中尺寸播放",description: "嵌入视频播放",function_name:"normal",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| "<video src='"+file.to_s+"?random="+rand(999999).to_s+"' controls='controls' class='normal-video'>你的浏览器不支持播放视频</video>" }})
  	video.property_opers.create!(name: "大尺寸播放",description: "嵌入视频播放",function_name:"big",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| "<video src='"+file.to_s+"?random="+rand(999999).to_s+"' controls='controls' class='big-video'>你的浏览器不支持播放视频</video>" }})
  	video.property_opers.create!(name: "文件大小",description: "文件大小",function_name:"size",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| (size/1024).floor.to_s+'K' }})
  	
    music.property_opers.create!(name: "嵌入播放",description: "嵌入音频播放",function_name:"play",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| "<audio controls><source src='"+file.to_s+"'>你的浏览器不支持播放音频</audio>" }})
    music.property_opers.create!(name: "文件大小",description: "文件大小",function_name:"size",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| (size/1024).floor.to_s+'K' }})
  	
    file.property_opers.create!(name: "文件大小",description: "文件大小",function_name:"size",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| (size/1024).floor.to_s+'K' }})
    
    pdf.property_opers.create!(name: "嵌入查看",description: "嵌入查看",function_name:"origin",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| "<div class='view-pdf' data-url='"+file.to_s+"' id='"+name+rand(999999).to_s+"'>你的浏览器没有安装pdf查看器，<a href='"+file.to_s+"'>点击下载</a></audio>" }})
  	pdf.property_opers.create!(name: "文件大小",description: "文件大小",function_name:"size",params: [],function_context: %Q{property_oper = lambda{ |name,file,size| (size/1024).floor.to_s+'K' }})

  end

  def self.down
  	PropertyType.all.each { |e| e.property_opers.destroy_all }
  end
end