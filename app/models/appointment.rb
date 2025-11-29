# app/models/appointment.rb
class Appointment < ApplicationRecord
  belongs_to :patient
  
  enum status: { scheduled: 0, confirmed: 1, completed: 2, cancelled: 3 }
  
  validates :scheduled_at, presence: true
  
  broadcasts_to :patient
end
