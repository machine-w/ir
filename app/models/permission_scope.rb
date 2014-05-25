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

  def get_users
  	result=[]
  	self.array_value.each do |user_id|
  		begin
  			result.push User.find(user_id)
  		rescue
  			next
  		end 
  	end 
  	result
  end
  def get_departments
  	result=[]
  	self.array_value.each do |depart_id|
  		begin
  			result.push Department.find(depart_id)
  		rescue
  			next
  		end 
  	end 
  	result
  end
  def get_disciplines
  	result=[]
  	self.array_value.each do |dis_id|
  		begin
  			result.push ThirdDiscipline.find(dis_id)
  		rescue
  			next
  		end 
  	end 
  	result
  end
  def get_groups
  	result=[]
  	self.array_value.each do |group_id|
  		begin
  			result.push Group.find(group_id)
  		rescue
  			next
  		end 
  	end 
  	result
  end
  def visiable?(visitor,user)
    case self.type
    when :my_department
      if visitor.department == user.department
        return true 
      else
        return false
      end
    when :sel_department
      if self.get_departments.include?(visitor.department)
        return true 
      else
        return false
      end
    when :my_discipline
      if (visitor.third_disciplines.entries & user.third_disciplines.entries) != [] 
        return true
      else
        return false
      end
    when :sel_discipline
      if (visitor.third_disciplines.entries & self.get_disciplines) != [] 
        return true
      else
        return false
      end
    when :my_group,:join_group
      if (visitor.my_join_groups.entries & self.get_groups) != []
        return true
      else
        return false
      end
    when :my_contact
      if user.contacts.where(firend: visitor).exists?
        return true
      else
        return false
      end
    when :sel_contact,:user_list
      if self.get_users.include?(visitor)
        return true
      else
        return false
      end

    end
  end
end
