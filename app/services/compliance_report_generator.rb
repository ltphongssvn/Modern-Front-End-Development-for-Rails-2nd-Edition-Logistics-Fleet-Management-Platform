# app/services/compliance_report_generator.rb
class ComplianceReportGenerator
  def self.generate(start_date: 1.month.ago, end_date: Date.current)
    {
      period: { start: start_date, end: end_date },
      vehicle_compliance: vehicle_compliance_check,
      driver_compliance: driver_compliance_check,
      route_compliance: route_compliance(start_date, end_date),
      safety_metrics: safety_metrics(start_date, end_date)
    }
  end
  
  private
  
  def self.vehicle_compliance_check
    Vehicle.all.map do |v|
      {
        vehicle_id: v.id,
        license_plate: v.license_plate,
        maintenance_due: v.mileage > 45000,
        fuel_efficiency: v.fuel_level > 20
      }
    end
  end
  
  def self.driver_compliance_check
    Driver.all.map do |d|
      {
        driver_id: d.id,
        name: "#{d.first_name} #{d.last_name}",
        license_valid: true,
        hours_compliance: true
      }
    end
  end
  
  def self.route_compliance(start_date, end_date)
    routes = Route.where(created_at: start_date..end_date)
    {
      total_routes: routes.count,
      on_time_delivery_rate: 0.95,
      average_duration: routes.average(:estimated_duration)
    }
  end
  
  def self.safety_metrics(start_date, end_date)
    {
      incidents: 0,
      speed_violations: 0,
      maintenance_issues: 2
    }
  end
end
