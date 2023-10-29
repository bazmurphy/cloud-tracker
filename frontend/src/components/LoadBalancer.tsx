import "./LoadBalancer.css";

function LoadBalancer() {
  return (
    <p className="load-balancer">
      Load Balancer directed to: {window.location.hostname}
    </p>
  );
}

export default LoadBalancer;
