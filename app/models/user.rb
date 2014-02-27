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
  ##other field
  field :verified, :type => Mongoid::Boolean, :default => false
  field :state, :type => Integer, :default => 1
  field :guest, :type => Mongoid::Boolean, :default => false
  
  index :loginname => 1
  index :email => 1
  validates_presence_of :loginname
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
  belongs_to :department
  has_many :folders, :dependent => :destroy
  has_and_belongs_to_many :third_disciplines
end
