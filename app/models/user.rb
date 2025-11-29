# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { driver: 0, fleet_manager: 1, admin: 2 }
  
  after_initialize :set_default_role, if: :new_record?
  
  private
  
  def set_default_role
    self.role ||= :driver
  end
end
