class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :set_admin

  def admin?
    admin
  end

  private
  
  def set_admin
    self.admin = true unless User.last
  end
end
