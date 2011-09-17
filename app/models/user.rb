class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :registerable, :recoverable, :rememberable
  belongs_to :role
  devise :database_authenticatable, :trackable, :validatable,:registerable,
  :recoverable, :rememberable,  :validatable

  has_many :orders
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_id, :access_until, :login,:status
  
  validates_presence_of   :login
  validates_uniqueness_of :login

  def update_active
    self.status = "active"
    self.save
  end
  
  def admin?
    !self.role.nil?
  end

  def access_until?
    true
  end
end
