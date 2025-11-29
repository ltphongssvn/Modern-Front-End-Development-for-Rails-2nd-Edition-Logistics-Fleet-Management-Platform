# app/services/driver_timesheet_service.rb
class DriverTimesheetService
  def self.generate_report(driver, start_date, end_date)
    routes = Route.where(driver_id: driver.id, created_at: start_date..end_date)
    
    {
      driver: driver.attributes,
      period: { start: start_date, end: end_date },
      total_hours: calculate_hours(routes),
      total_distance: routes.sum(:distance),
      deliveries_completed: routes.joins(:deliveries).where(deliveries: { status: 'completed' }).count,
      routes_completed: routes.where(status: 'completed').count,
      daily_breakdown: generate_daily_breakdown(routes)
    }
  end
  
  private
  
  def self.calculate_hours(routes)
    routes.sum(:estimated_duration) / 60.0
  end
  
  def self.generate_daily_breakdown(routes)
    routes.group_by { |r| r.created_at.to_date }.map do |date, day_routes|
      {
        date: date,
        hours: calculate_hours(day_routes),
        distance: day_routes.sum(:distance),
        routes: day_routes.count
      }
    end
  end
end
