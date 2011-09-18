class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me , :role
  ROLES = %w[admin staff manager]

  def admin?
    self.role == "admin"
  end

  def staff?
    self.role == "staff"
  end

  def manager?
    self.role == "manager"
  end
end
