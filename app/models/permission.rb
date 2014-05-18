class Permission
  include Mongoid::Document
  include SimpleEnum::Mongoid

  field :inherit, :type => Boolean , :default => false
  field :private, :type => Boolean , :default => true
  as_enum :public_type, :all => 1, :user => 2, :scope => 3
  field :end_date, :type => Date

  embeds_many :permission_scopes
  embedded_in :document
  embedded_in :folder
end
