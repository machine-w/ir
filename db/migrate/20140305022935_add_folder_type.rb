class AddFolderType < Mongoid::Migration
  def self.up
  	FolderType.create(name: "论文",list_view: "thesis", image_path: "fa-credit-card",user_can_select: true)
	FolderType.create(name: "书籍",list_view: "book", image_path: "fa-book",user_can_select: true)
	FolderType.create(name: "专利",list_view: "patent", image_path: "fa-th-large",user_can_select: true)
	FolderType.create(name: "博客",list_view: "blog", image_path: "fa-home",user_can_select: true)
	FolderType.create(name: "笔记",list_view: "note", image_path: "fa-lightbulb-o",user_can_select: true)
	FolderType.create(name: "图片",list_view: "picture", image_path: "fa-picture-o",user_can_select: true)
	FolderType.create(name: "视频",list_view: "video", image_path: "fa-video-camera",user_can_select: true)
	FolderType.create(name: "音乐",list_view: "music", image_path: "fa-music",user_can_select: true)
	FolderType.create(name: "文件",list_view: "file", image_path: "fa-folder-o",user_can_select: true)
	FolderType.create(name: "数据",list_view: "data", image_path: "fa-table",user_can_select: true)
  end
  def self.down
  	FolderType.delete_all()
  end
end