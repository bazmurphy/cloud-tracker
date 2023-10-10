import "./CourseworkCard.css";
import { CourseworkCardProps, Trainee } from "../types/types";
import { useEffect, useState } from "react";
import TraineeContainer from "./TraineeContainer";
import { getImage } from "../utils/getImage";

const CourseworkCard = ({ courseworkItem }: CourseworkCardProps) => {
  const { coursework_id, description } = courseworkItem;

  const [trainees, setTrainees] = useState([]);

  const fetchTraineeCoursework = async () => {
    try {
      const response = await fetch(
        `${import.meta.env.VITE_API_URL}/api/trainees`
      );
      if (!response.ok) {
        throw response;
      }
      const data = await response.json();
      // console.log("fetchTraineeCoursework:", data);
      setTrainees(data.payload);
    } catch (error) {
      console.log("catch block error:", error);
    }
  };

  useEffect(() => {
    fetchTraineeCoursework();
  }, []);

  return (
    <div className="coursework-card" key={coursework_id}>
      <div className="coursework-card-description">
        <img
          className="coursework-card-image"
          src={getImage(description)}
          alt=""
        />
        <h4 className="courseword-card-description-part-one">
          {description.split(" : ")[0]}
        </h4>
        <h3 className="courseword-card-description-part-two">
          {description.split(" : ")[1]}
        </h3>
      </div>
      <div className="coursework-card-trainees-container">
        {trainees.map((trainee: Trainee) => {
          return (
            <TraineeContainer
              key={trainee.trainee_id}
              trainee={trainee}
              courseworkId={coursework_id}
            />
          );
        })}
      </div>
    </div>
  );
};

export default CourseworkCard;
