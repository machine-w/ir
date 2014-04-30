class Notification
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::BaseModel
  include SimpleEnum::Mongoid

  field :title
  field :content
  field :footer
  field :unread, :type => Boolean,:default => true
  as_enum :type,:add_doc => 1,:add_folder => 2, :modify_doc => 3, 
    			:modify_folder => 4,  :firend_to_me => 5, 
    			:group_to_me => 6,:child_share_doc => 7,
    			:child_modify_doc => 8, :open_doc_to_me => 9,
    			:del_doc => 10,:del_folder =>11,:del_contact=>12,
    			:del_group =>13,:add_contact =>14,:add_group => 15
  scope :un_read, where(unread: true).desc('create_at').limit(99)

  belongs_to :ind_document, class_name: "Document", inverse_of: nil
  belongs_to :ind_folder, class_name: "Folder", inverse_of: nil
  belongs_to :user

  def type_img
  	case self.type
  	when :add_doc,:modify_doc,:del_doc
  		'fa fa-file'
  	when :add_folder,:modify_folder,:del_folder
  		'fa fa-folder'
  	when :add_contact,:del_contact
  		'fa fa-user'
  	when :add_group,:del_group
  		'fa fa-users'
  	when :firend_to_me
  		'ion ion-person-add'
  	when :group_to_me
  		'ion ion-person-stalker'
  	when :open_doc_to_me
  		'ion ion-eye'
  	when :child_share_doc
  		'fa fa-share-square-o'
  	when :child_modify_doc
  		'fa fa-share-square'
  	end
  end
  def type_color
  	case self.type
  	when :add_group,:add_contact,:add_folder,:add_doc
  		'bg-green'
  	when :modify_folder,:modify_doc,:child_modify_doc
  		'bg-aqua'
  	when :del_folder,:del_group,:del_contact,:del_doc
  		'bg-red'
  	when :firend_to_me,:group_to_me,:open_doc_to_me
  		'bg-blue'
  	else
  		'bg-yellow'
  	end
  end
  def set_read!
    self.update_attribute(:unread,false) if self.unread
  end
end


