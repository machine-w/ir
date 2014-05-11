class GmReaded
  include Mongoid::Document

  belongs_to :user, class_name: "User", inverse_of: nil

  embedded_in :group_message
  
end
