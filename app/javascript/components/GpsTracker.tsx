// app/javascript/components/GpsTracker.tsx
import React, { useEffect, useState } from 'react';

interface GpsData {
  vehicle_id: number;
  latitude: number;
  longitude: number;
  speed: number;
  heading: number;
  timestamp: string;
}

const GpsTracker: React.FC<{ vehicleId: number }> = ({ vehicleId }) => {
  const [position, setPosition] = useState<GpsData | null>(null);

  useEffect(() => {
    const ws = new WebSocket(`ws://localhost:3000/cable`);
    
    ws.onopen = () => {
      ws.send(JSON.stringify({
        command: 'subscribe',
        identifier: JSON.stringify({
          channel: 'GpsChannel',
          vehicle_id: vehicleId
        })
      }));
    };

    ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      if (data.type === 'ping') return;
      if (data.message) {
        setPosition(data.message);
      }
    };

    return () => ws.close();
  }, [vehicleId]);

  if (!position) return <div>Waiting for GPS signal...</div>;

  return (
    <div className="bg-white p-4 rounded shadow">
      <h3 className="font-bold mb-2">Live GPS Position</h3>
      <div className="text-sm space-y-1">
        <div>Lat: {position.latitude.toFixed(6)}</div>
        <div>Lng: {position.longitude.toFixed(6)}</div>
        <div>Speed: {position.speed} km/h</div>
        <div>Heading: {position.heading}°</div>
      </div>
    </div>
  );
};

export default GpsTracker;
