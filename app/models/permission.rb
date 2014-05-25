class Permission
  include Mongoid::Document
  include SimpleEnum::Mongoid

  field :inherit, :type => Boolean , :default => true
  field :privated, :type => Boolean , :default => true
  field :list_search_visiable, :type => Boolean , :default => true
  as_enum :public_type, :all => 1, :user => 2, :scope => 3
  field :end_date, :type => Date

  validates_presence_of :inherit

  embeds_many :permission_scopes
  embedded_in :document
  embedded_in :folder
end
