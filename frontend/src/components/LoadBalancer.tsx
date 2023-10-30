import "./LoadBalancer.css";

function LoadBalancer() {
  const ec2InternalIp = import.meta.env.VITE_EC2_INTERNAL_IP;
  console.log("ec2InternalIp:", ec2InternalIp);
  return (
    <p className="load-balancer">Load Balancer routed to {ec2InternalIp}</p>
  );
}

export default LoadBalancer;
