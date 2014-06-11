class AddPropertyOper < Mongoid::Migration
  def self.up
  	str = PropertyType.where(type_view_cd: 1).first
  	str.property_opers.create!(name: "长度",description: "获取字符串长度",function_name:"size",params: [],function_context: "property_oper = lambda{ |str| str.length}")
  end

  def self.down
  	PropertyType.all.each { |e| e.property_opers.destroy_all }
  end
end