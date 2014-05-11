class GroupMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  belongs_to :from, class_name: "User", inverse_of: nil
  belongs_to :add_document, class_name: "Document", inverse_of: nil
  field :content
  #field :unread, :type => Boolean,:default => true 
  belongs_to :group
  embeds_many :unreads,class_name: "GmReaded", cascade_callbacks: true
  def set_readed(user)
  	if self.unreads.where(user: user).exists?
  		self.unreads.where(user: user).destroy
  	end
  end
end
