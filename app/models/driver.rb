# app/models/driver.rb
class Driver < ApplicationRecord
  belongs_to :vehicle, optional: true
end
