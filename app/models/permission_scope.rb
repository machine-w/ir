class PermissionScope
  include Mongoid::Document
  include SimpleEnum::Mongoid

  as_enum :type, :my_department => 1, :sel_department => 2, :my_discipline => 3,:sel_discipline => 4,
  				 :my_group => 5,:join_group => 6,:my_contact => 7,:user_list =>8
  field :array_value, :type => Array

  embeds_many :m,class_name: "PsMember"
  embeds_many :d,class_name: "PsDepartment"
  embeds_many :x,class_name: "PsDiscipline"
  embedded_in :permission
end
