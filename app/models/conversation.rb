class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  before_save :users_size_gl_two
  embeds_many :messages, cascade_callbacks: true
  has_and_belongs_to_many :users

  def set_readed
  	self.messages.each { |e| e.unread = false }
  	self.save
  end
  def clear_messages
  	self.messages.all.destroy
  	self.save
  end
  private
  def users_size_gl_two
    self.users.size >= 2 ? true : false 
  end
end
