import { useState, useEffect } from "react";
import "./LoadBalancer.css";

function LoadBalancer() {
  const [clientIP, setClientIP] = useState("");

  useEffect(() => {
    const getClientIP = async () => {
      try {
        const response = await fetch("/api/get-client-ip");
        const data = await response.json();
        setClientIP(data.clientIP);
      } catch (error) {
        console.error(error);
      }
    };
    getClientIP();
  }, []);

  return (
    <p className="load-balancer">
      Load Balancer routed to:{" "}
      {clientIP ? window.location.hostname : "loading..."}
    </p>
  );
}

export default LoadBalancer;
