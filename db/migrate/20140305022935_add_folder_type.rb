class AddFolderType < Mongoid::Migration
  def self.up
  	FolderType.create(name: "论文",list_view: "thesis", image_path: "icon-credit-card",user_can_select: true)
	FolderType.create(name: "书籍",list_view: "book", image_path: "icon-book",user_can_select: true)
	FolderType.create(name: "专利",list_view: "patent", image_path: "icon-th-large",user_can_select: true)
	FolderType.create(name: "博客",list_view: "blog", image_path: "icon-home",user_can_select: true)
	FolderType.create(name: "笔记",list_view: "note", image_path: "icon-lightbulb",user_can_select: true)
	FolderType.create(name: "图片",list_view: "picture", image_path: "icon-picture",user_can_select: true)
	FolderType.create(name: "视频",list_view: "video", image_path: "icon-facetime-video",user_can_select: true)
	FolderType.create(name: "音乐",list_view: "music", image_path: "icon-music",user_can_select: true)
	FolderType.create(name: "文件",list_view: "file", image_path: "icon-folder-close-alt",user_can_select: true)
	FolderType.create(name: "数据",list_view: "data", image_path: "icon-table",user_can_select: true)
  end
  def self.down
  	FolderType.delete_all()
  end
end