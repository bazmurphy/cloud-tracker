import "./Error.css";
import { ErrorProps } from "../types/types";

const Error = ({ error, setRetry }: ErrorProps) => {
  return (
    <div className="error-container">
      <div className="error-subcontainer">
        <img className="error-image" src="./images/error.png" alt="" />
        <p className="error-message">Error...</p>
      </div>
      <p className="error-details">{error.message}</p>
      <button
        className="error-retry-button"
        onClick={() => {
          setRetry((prevRetry) => !prevRetry);
        }}
      >
        Retry
      </button>
    </div>
  );
};

export default Error;
