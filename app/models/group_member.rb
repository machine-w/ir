class GroupMember
  include Mongoid::Document
  include SimpleEnum::Mongoid
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  belongs_to :user, class_name: "User", inverse_of: nil
  #成员类型
  as_enum :type, :master => 1,:admin => 2, :normal => 3
  field :sort, :type => Integer, :default => 0
  embedded_in :group

  def type_name
  	case self.type
  	when :master
  		'建立者'
  	when :admin
  		'管理员'
  	when :normal
  		'组成员'
  	end
  end
end
