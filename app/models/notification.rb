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
    			:del_group =>13,:add_contact =>14,:add_group => 15,
          :add_property => 16,:modify_property => 17,:del_property => 18,
          :m_folder_view => 19,:m_folder_static => 20,:modify_user => 21,
          :modify_group => 22,:add_group_member => 23,:del_group_member => 24,
          :modify_group_member => 25,:group_del_me => 26,:group_modify_me => 27,
          :logout_group =>28,:child_shield_doc =>29,:copy_doc => 30
  scope :un_read, where(unread: true).desc('create_at').limit(99)

  #belongs_to :ind_document, class_name: "Document", inverse_of: nil
  #belongs_to :ind_folder, class_name: "Folder", inverse_of: nil
  belongs_to :user

  def type_img
  	case self.type
  	when :add_doc,:modify_doc,:del_doc
  		'fa fa-file'
    when :add_property,:modify_property,:del_property
      'fa fa-gear'
  	when :add_folder,:modify_folder,:del_folder,:m_folder_static,:m_folder_view
  		'fa fa-folder'
  	when :add_contact,:del_contact
  		'fa fa-user'
  	when :add_group,:del_group,:modify_group
  		'fa fa-users'
  	when :firend_to_me
  		'ion ion-person-add'
  	when :group_to_me,:group_del_me,:group_modify_me
  		'ion ion-person-stalker'
  	when :open_doc_to_me
  		'ion ion-eye'
  	when :child_share_doc,:child_shield_doc
  		'fa fa-share-square-o'
  	when :child_modify_doc
  		'fa fa-share-square'
    when :modify_user
      'fa fa-heart'
    when :add_group_member,:del_group_member,:modify_group_member
      'ion ion-ios7-people'
    when :logout_group
      'ion ion-android-hand'
    when :copy_doc
      'fa fa-copy'
  	end
  end
  def type_color
  	case self.type
  	when :add_group,:add_contact,:add_folder,:add_doc,:add_property,:add_group_member,:group_to_me,:child_share_doc,:copy_doc
  		'bg-green'
  	when :modify_folder,:modify_doc,:child_modify_doc,:modify_property,:modify_user,
         :modify_group,:modify_group_member,:group_modify_me
  		'bg-aqua'
  	when :del_folder,:del_group,:del_contact,:del_doc,:del_property,:del_group_member,:group_del_me,:logout_group,:child_shield_doc
  		'bg-red'
  	when :firend_to_me,:open_doc_to_me
  		'bg-blue'
    when :child_modify_doc
      'bg-orange'
  	else
  		'bg-yellow'
  	end
  end
  def set_read!
    self.update_attribute(:unread,false) if self.unread
  end
end


