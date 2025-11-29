// app/javascript/components/MapView.tsx
import React, { useEffect, useRef } from 'react';

interface MapViewProps {
  vehicles: any[];
  selectedVehicle: number | null;
}

const MapView: React.FC<MapViewProps> = ({ vehicles, selectedVehicle }) => {
  const mapRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    // Placeholder for map initialization
    if (mapRef.current) {
      mapRef.current.innerHTML = `
        <div class="flex items-center justify-center h-full bg-gray-200 rounded-lg">
          <div class="text-center">
            <svg class="w-24 h-24 mx-auto text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7"></path>
            </svg>
            <p class="mt-4 text-lg font-semibold">Real-time GPS Tracking</p>
            <p class="text-gray-600">${vehicles.length} vehicles active</p>
          </div>
        </div>
      `;
    }
  }, [vehicles, selectedVehicle]);

  return (
    <div className="bg-white rounded-lg shadow-lg p-4">
      <h2 className="text-xl font-bold mb-4">Fleet Map</h2>
      <div ref={mapRef} className="h-96 bg-gray-100 rounded-lg" />
    </div>
  );
};

export default MapView;
