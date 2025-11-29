# db/seeds.rb
User.find_or_create_by(email: 'admin@fleet.com') do |u|
  u.password = 'password123'
  u.role = 'admin'
end

User.find_or_create_by(email: 'manager@fleet.com') do |u|
  u.password = 'password123'
  u.role = 'fleet_manager'
end

User.find_or_create_by(email: 'driver1@fleet.com') do |u|
  u.password = 'password123'
  u.role = 'driver'
end

5.times do |i|
  Vehicle.find_or_create_by(license_plate: "FL-#{1000 + i}") do |v|
    v.vin = "VIN#{SecureRandom.hex(8).upcase}"
    v.make = ['Ford', 'Mercedes', 'Volvo'][i % 3]
    v.model = ['Transit', 'Sprinter', 'FH16'][i % 3]
    v.year = 2020 + (i % 3)
    v.vehicle_type = 'delivery_van'
    v.status = 'active'
    v.fuel_level = rand(30..100)
    v.mileage = rand(10000..50000)
    v.current_location = { lat: 33.7490 + rand(-0.1..0.1), lng: -84.3880 + rand(-0.1..0.1) }
  end
end

3.times do |i|
  Driver.find_or_create_by(email: "driver#{i+1}@fleet.com") do |d|
    d.first_name = ['John', 'Sarah', 'Mike'][i]
    d.last_name = ['Smith', 'Johnson', 'Williams'][i]
    d.license_number = "DL#{1000 + i}"
    d.phone = "555-#{1000 + i}"
    d.status = 'available'
    d.vehicle_id = i + 1
  end
end
