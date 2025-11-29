// app/javascript/types/index.ts
export interface Vehicle {
  id: number;
  license_plate: string;
  vin: string;
  make: string;
  model: string;
  year: number;
  vehicle_type: string;
  status: string;
  current_location: Location;
  fuel_level: number;
  mileage: number;
}

export interface Location {
  lat: number;
  lng: number;
}

export interface Driver {
  id: number;
  first_name: string;
  last_name: string;
  license_number: string;
  phone: string;
  email: string;
  status: string;
  vehicle_id?: number;
}

export interface Route {
  id: number;
  name: string;
  origin: Location;
  destination: Location;
  waypoints: Location[];
  distance: number;
  estimated_duration: number;
  status: string;
  driver_id: number;
  vehicle_id: number;
}

export interface Delivery {
  id: number;
  tracking_number: string;
  route_id: number;
  status: string;
  pickup_time: string;
  delivery_time?: string;
  recipient_name: string;
  package_details: any;
}
