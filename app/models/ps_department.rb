class PsDepartment
  include Mongoid::Document
  belongs_to :department, class_name: "Department", inverse_of: nil
  embedded_in :permission_scope
end
