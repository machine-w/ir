class Attritube
  include Mongoid::Document
  include SimpleEnum::Mongoid
  include ActionView::Helpers::TextHelper
  field :property_id, :type => Moped::BSON::ObjectId
  field :string_value
  field :float_value, :type => Float
  field :int_value, :type => Integer
  field :bool_value, :type => Boolean
  field :array_value, :type => Array
end
