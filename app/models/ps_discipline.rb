class PsDiscipline
  include Mongoid::Document
  belongs_to :discipline, class_name: "ThirdDiscipline", inverse_of: nil
  embedded_in :permission_scope
end
