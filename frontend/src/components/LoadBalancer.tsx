// import { useState, useEffect } from "react";
import "./LoadBalancer.css";

function LoadBalancer() {
  return (
    <p className="load-balancer">
      Load Balancer routed to {import.meta.env.VITE_EC2_INTERNAL_IP}
    </p>
  );
}

export default LoadBalancer;
