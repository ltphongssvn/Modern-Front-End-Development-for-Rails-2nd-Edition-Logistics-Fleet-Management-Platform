// app/javascript/components/DeliveryStatus.tsx
import React, { useState, useEffect } from 'react';

const DeliveryStatus: React.FC = () => {
  const [deliveries, setDeliveries] = useState<any[]>([]);

  useEffect(() => {
    fetch('/api/v1/deliveries')
      .then(res => res.json())
      .then(data => setDeliveries(data))
      .catch(() => setDeliveries([]));
  }, []);

  return (
    <div className="bg-white rounded-lg shadow-lg p-4">
      <h2 className="text-xl font-bold mb-4">Active Deliveries</h2>
      <div className="space-y-2">
        {deliveries.slice(0, 5).map((delivery: any) => (
          <div key={delivery.id} className="p-3 border rounded-lg">
            <div className="font-semibold">{delivery.tracking_number}</div>
            <div className="text-sm text-gray-600">{delivery.status}</div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default DeliveryStatus;
