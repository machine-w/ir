# -*- coding: utf-8 -*-
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include SimpleEnum::Mongoid
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  # Email md5
  field :email_md5
  # Email shifougongkai
  field :email_public, :type => Mongoid::Boolean  
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :loginname
  field :username
  mount_uploader :avatar, AvatarUploader
  field :gender
  ##other field
  field :verified, :type => Mongoid::Boolean, :default => false
  field :state, :type => Integer, :default => 1
  as_enum :level, [:register, :indentified, :vip,:super ], :field => { :type => Integer, :default => 0 }
  field :guest, :type => Mongoid::Boolean, :default => false
  field :view_pubu, :default => 'list'
  field :view_fixheader, :type => Mongoid::Boolean, :default => false
  index :loginname => 1
  index :email => 1
  validates_presence_of :loginname,:department_id,:user_type_id
  validates_uniqueness_of :loginname, :email, :case_sensitive => false
  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  ## start customs
  attr_accessor :login

  belongs_to :department
  belongs_to :user_type
  has_many :folders, :dependent => :destroy
  has_many :folder_groups, :dependent => :destroy
  has_many :contacts,:dependent => :destroy
  has_many :groups,:dependent => :destroy
  has_many :notifications,:dependent => :destroy
  has_many :todolists, :dependent => :destroy
  #has_many :contacted, class_name: "Contact", inverse_of: :firend
  has_and_belongs_to_many :third_disciplines
  has_and_belongs_to_many :conversations,:dependent => :destroy
  embeds_many :backpictures, cascade_callbacks: true
  #before_save :set_default_depart
  after_destroy :destroy_other_relation

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :loginname =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
  def my_join_groups
    Group.elem_match(group_members: { user_id: self._id })
  end
  def get_backpicture
    pics= []
    self.backpictures.all.each do |b|  
      case b.type
      when :system
        pics.push(b.picture.image_url) if b.picture
      when :custom
        pics.push(b.image_url)
      end
    end
    pics.to_json
  end
  def get_level_view
    case self.level
      when :register
        "fa  fa-linkedin-square fa-2x text-success"
      when :indentified
        "fa fa-vimeo-square  fa-2x text-primary"
      when :vip
        "fa fa-vimeo-square fa-2x text-warning"
      when :super
        "fa fa-vimeo-square fa-2x text-danger"
      else
        "fa fa-linkedin-square fa-2x text-info"
    end
  end
  protected
  # def set_default_depart
  #   #self.department = Department.where(name: '未知单位').first if self.new_record?
  # end
  def destroy_other_relation
    Contact.where(firend: self).destroy
    Message.where(from: self).destroy
    self.my_join_groups.each { |e| e.group_members.where(user: self).destroy; e.save }
    GroupMessage.where(from: self).destroy
  end
end
