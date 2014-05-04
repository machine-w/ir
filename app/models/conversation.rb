class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  before_save :users_size_gl_two
  #embeds_many :messages, cascade_callbacks: true
  has_many :messages, autosave: true
  has_and_belongs_to_many :users

  def set_readed(user)
  	self.messages.where(from: user).each { |e| e.unread = false;e.save }
  	#self.save
  end
  def clear_messages
  	self.messages.all.destroy
  	self.save
  end
  def get_other_user(user)
    users=self.users
    users[0] ==  user  ? users[1] : users[0]
  end
  private
  def users_size_gl_two
    self.users.size >= 2 ? true : false 
  end

end
