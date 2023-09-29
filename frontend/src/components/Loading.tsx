import "./Loading.css";

const Loading = () => {
  return (
    <div className="loading-container">
      <img className="loading-image" src="./images/loading.png" alt="" />
      <p className="loading-message">Loading...</p>
    </div>
  );
};

export default Loading;
