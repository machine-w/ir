class PermissionScope
  include Mongoid::Document
  include SimpleEnum::Mongoid

  as_enum :type, :my_department => 1, :sel_department => 2, :my_discipline => 3,:sel_discipline => 4,
  				 :my_group => 5,:join_group => 6,:my_contact => 7,:sel_contact => 8,:user_list =>9
  field :array_value, :type => Array

  # embeds_many :members,class_name: "PsMember"
  # embeds_many :departments,class_name: "PsDepartment"
  # embeds_many :disciplines,class_name: "PsDiscipline"
  embedded_in :permission
end
