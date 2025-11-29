// app/javascript/components/TelemetryDashboard.tsx
import React, { useState, useEffect } from 'react';

interface TelemetryData {
  engine_temp: number;
  oil_pressure: number;
  battery_voltage: number;
  tire_pressure: any;
}

const TelemetryDashboard: React.FC<{ vehicleId: number }> = ({ vehicleId }) => {
  const [telemetry, setTelemetry] = useState<TelemetryData | null>(null);

  useEffect(() => {
    const fetchTelemetry = () => {
      fetch(`/api/v1/telemetries?vehicle_id=${vehicleId}`)
        .then(res => res.json())
        .then(data => data[0] && setTelemetry(data[0]));
    };
    
    fetchTelemetry();
    const interval = setInterval(fetchTelemetry, 5000);
    return () => clearInterval(interval);
  }, [vehicleId]);

  if (!telemetry) return <div>Loading telemetry...</div>;

  return (
    <div className="grid grid-cols-2 gap-4">
      <div className="bg-white p-3 rounded shadow">
        <div className="text-xs text-gray-600">Engine Temp</div>
        <div className="text-2xl font-bold">{telemetry.engine_temp}°C</div>
      </div>
      <div className="bg-white p-3 rounded shadow">
        <div className="text-xs text-gray-600">Oil Pressure</div>
        <div className="text-2xl font-bold">{telemetry.oil_pressure} PSI</div>
      </div>
      <div className="bg-white p-3 rounded shadow">
        <div className="text-xs text-gray-600">Battery</div>
        <div className="text-2xl font-bold">{telemetry.battery_voltage}V</div>
      </div>
      <div className="bg-white p-3 rounded shadow">
        <div className="text-xs text-gray-600">Tire Pressure</div>
        <div className="text-2xl font-bold">OK</div>
      </div>
    </div>
  );
};

export default TelemetryDashboard;
