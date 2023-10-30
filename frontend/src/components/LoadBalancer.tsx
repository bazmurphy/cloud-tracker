import "./LoadBalancer.css";
import { useState, useEffect } from "react";

function LoadBalancer() {
  const [internalIP, setInternalIP] = useState("x.x.x.x");

  const getInternalIP = async () => {
    try {
      const response = await fetch("/api/internal-ip");
      const data = await response.json();
      setInternalIP(data.payload);
    } catch (error) {
      console.error("getInternalIP Error", error);
    }
  };

  useEffect(() => {
    getInternalIP();
  }, []);

  return <p className="load-balancer">Load Balancer routed to {internalIP}</p>;
}

export default LoadBalancer;
