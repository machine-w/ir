class GroupMember
  include Mongoid::Document
  include SimpleEnum::Mongoid

  belongs_to :user, class_name: "User", inverse_of: nil
  #成员类型
  as_enum :type, :master => 1,:admin => 2, :normal => 3
  field :sort, :type => Integer, :default => 0
  embedded_in :group
end
