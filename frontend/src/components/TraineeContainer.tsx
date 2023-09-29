import CourseworkProgress from "./CourseworkProgress";
import { TraineeContainerProps } from "../types/types";
import "./TraineeContainer.css";

const TraineeContainer = ({ trainee, courseworkId }: TraineeContainerProps) => {
  return (
    <div key={trainee.trainee_id} className="coursework-card-trainee-container">
      <p className="coursework-card-trainee-name-container">
        <span className="coursework-card-trainee-name-first">
          {trainee.first_name}
        </span>
        <span className="coursework-card-trainee-name-last">
          {trainee.last_name}
        </span>
      </p>
      <CourseworkProgress
        courseworkId={courseworkId}
        traineeId={trainee?.trainee_id}
      />
    </div>
  );
};
export default TraineeContainer;
