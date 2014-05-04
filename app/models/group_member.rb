class GroupMember
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include SimpleEnum::Mongoid

  belongs_to :user, class_name: "User", inverse_of: nil
  #成员类型
  as_enum :type, :master => 1, :admin => 2, :normal => 3
  embedded_in :group
end
