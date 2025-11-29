# app/services/route_optimizer.rb
class RouteOptimizer
  def self.optimize(route)
    waypoints = route.waypoints || []
    return route if waypoints.empty?
    
    optimized = waypoints.sort_by { |w| 
      distance_between(route.origin, w)
    }
    
    route.update(
      waypoints: optimized,
      distance: calculate_total_distance(route.origin, optimized, route.destination),
      estimated_duration: calculate_duration(route.distance)
    )
    route
  end
  
  private
  
  def self.distance_between(point1, point2)
    Math.sqrt((point1['lat'] - point2['lat'])**2 + (point1['lng'] - point2['lng'])**2)
  end
  
  def self.calculate_total_distance(origin, waypoints, destination)
    total = 0
    points = [origin] + waypoints + [destination]
    points.each_cons(2) { |a, b| total += distance_between(a, b) }
    total * 111 # km approximation
  end
  
  def self.calculate_duration(distance)
    (distance / 50.0 * 60).to_i # minutes at 50km/h average
  end
end
