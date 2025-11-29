// app/javascript/components/Dashboard.tsx
import React, { useState, useEffect } from 'react';
import MapView from './MapView';
import VehicleList from './VehicleList';
import DeliveryStatus from './DeliveryStatus';

interface Vehicle {
  id: number;
  license_plate: string;
  status: string;
  fuel_level: number;
  current_location: any;
}

const Dashboard: React.FC = () => {
  const [vehicles, setVehicles] = useState<Vehicle[]>([]);
  const [selectedVehicle, setSelectedVehicle] = useState<number | null>(null);

  useEffect(() => {
    fetch('/api/v1/vehicles')
      .then(res => res.json())
      .then(data => setVehicles(data));
  }, []);

  return (
    <div className="min-h-screen bg-gray-100">
      <nav className="bg-blue-600 text-white p-4">
        <h1 className="text-2xl font-bold">Fleet Management Dashboard</h1>
      </nav>
      <div className="container mx-auto p-4">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
          <div className="lg:col-span-2">
            <MapView vehicles={vehicles} selectedVehicle={selectedVehicle} />
          </div>
          <div>
            <VehicleList vehicles={vehicles} onSelectVehicle={setSelectedVehicle} />
            <DeliveryStatus />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
