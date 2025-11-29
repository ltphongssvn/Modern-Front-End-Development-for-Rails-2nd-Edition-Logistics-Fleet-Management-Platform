// app/javascript/components/VehicleList.tsx
import React from 'react';

interface VehicleListProps {
  vehicles: any[];
  onSelectVehicle: (id: number) => void;
}

const VehicleList: React.FC<VehicleListProps> = ({ vehicles, onSelectVehicle }) => {
  return (
    <div className="bg-white rounded-lg shadow-lg p-4 mb-4">
      <h2 className="text-xl font-bold mb-4">Vehicle Fleet</h2>
      <div className="space-y-2">
        {vehicles.map(vehicle => (
          <div
            key={vehicle.id}
            onClick={() => onSelectVehicle(vehicle.id)}
            className="p-3 border rounded-lg hover:bg-blue-50 cursor-pointer"
          >
            <div className="flex justify-between">
              <span className="font-semibold">{vehicle.license_plate}</span>
              <span className={`px-2 py-1 rounded text-xs ${
                vehicle.status === 'active' ? 'bg-green-100 text-green-800' : 'bg-gray-100'
              }`}>
                {vehicle.status}
              </span>
            </div>
            <div className="text-sm text-gray-600 mt-1">
              Fuel: {vehicle.fuel_level}% | {vehicle.make} {vehicle.model}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default VehicleList;
