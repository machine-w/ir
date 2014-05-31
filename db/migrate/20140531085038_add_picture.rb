class AddPicture < Mongoid::Migration
  def self.up
  	Picture.create(name: "背景1",image_url:"/images/back/back1.jpg")
  	Picture.create(name: "背景2",image_url:"/images/back/back2.jpg")
  	Picture.create(name: "背景3",image_url:"/images/back/back3.jpg")
  	Picture.create(name: "背景4",image_url:"/images/back/back4.jpg")
  end

  def self.down
  	Picture.delete_all()
  end
end