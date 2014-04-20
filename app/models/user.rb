# -*- coding: utf-8 -*-
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
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
  field :guest, :type => Mongoid::Boolean, :default => false
  
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
  has_many :contacts
  #has_many :contacted, class_name: "Contact", inverse_of: :firend
  has_and_belongs_to_many :third_disciplines
  has_and_belongs_to_many :conversations

  before_save :set_default_depart


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :loginname =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end

  protected
  def set_default_depart
    self.department = Department.where(name: '未知单位').first if self.new_record?
  end
end
