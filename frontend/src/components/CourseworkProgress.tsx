import "./CourseworkProgress.css";
import { CourseworkProgressProps, TraineeCoursework } from "../types/types";
import { useEffect, useState, ChangeEvent } from "react";

const CourseworkProgress = ({
  traineeId,
  courseworkId,
}: CourseworkProgressProps) => {
  const [traineeCoursework, setTraineeCoursework] = useState<TraineeCoursework>(
    {
      trainee_id: traineeId,
      coursework_id: courseworkId,
      in_progress: false,
      need_help: false,
      completed: false,
    }
  );

  const getTraineeCourseworkProgress = async () => {
    try {
      const response = await fetch(
        `/api/trainee-coursework/trainee=${traineeId}&coursework=${courseworkId}`
      );
      // console.log("getTraineeCourseworkProgress response:", response);

      if (!response.ok) {
        throw response;
      }

      const data = await response.json();
      // console.log("getTraineeCourseworkProgress:", data);
      if (data.success) {
        setTraineeCoursework(data.payload);
      }
    } catch (error) {
      console.log("catch block error:", error);
    }
  };

  const setTraineeCourseworkProgress = async (
    event: ChangeEvent<HTMLInputElement>
  ) => {
    // console.log("BEFORE STATE traineeCoursework", traineeCoursework);
    const updatedKey = event.target.value;
    const updatedValue = event.target.checked;
    // console.log("updatedKey:", updatedKey);
    // console.log("updatedValue:", updatedValue);

    try {
      const updatedBody = {
        ...traineeCoursework,
        [updatedKey]: updatedValue,
      };
      // console.log("updatedBody:", updatedBody);

      const response = await fetch(
        `/api/trainee-coursework/trainee=${traineeId}&coursework=${courseworkId}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(updatedBody),
        }
      );
      // console.log("setTraineeCourseworkProgress response:", response);

      if (!response.ok) {
        throw response;
      }

      const data = await response.json();
      // console.log("setTraineeCourseworkProgress data:", data);

      if (data.success) {
        setTraineeCoursework(data.payload);
        // console.log("AFTER STATE traineeCoursework", traineeCoursework);
      }
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    getTraineeCourseworkProgress();
  }, []);

  return (
    <>
      <div
        className={`progress-bar ${
          traineeCoursework.completed
            ? "progress-bar-completed"
            : traineeCoursework.need_help
            ? "progress-bar-need-help"
            : traineeCoursework.in_progress
            ? "progress-bar-in-progress"
            : ""
        }`}
      ></div>
      <div className="coursework-progress-container">
        <div className="coursework-progress-interactive-container">
          <input
            type="checkbox"
            className="checkbox-in-progress"
            value="in_progress"
            checked={traineeCoursework?.in_progress}
            onChange={setTraineeCourseworkProgress}
          />
          <label className="coursework-progress-interactive-label">
            In Progress
          </label>
        </div>
        <div className="coursework-progress-interactive-container">
          <input
            type="checkbox"
            className="checkbox-need-help"
            value="need_help"
            checked={traineeCoursework?.need_help}
            onChange={setTraineeCourseworkProgress}
          />
          <label className="coursework-progress-interactive-label">
            Need Help
          </label>
        </div>
        <div className="coursework-progress-interactive-container">
          <input
            type="checkbox"
            className="checkbox-completed"
            value="completed"
            checked={traineeCoursework?.completed}
            onChange={setTraineeCourseworkProgress}
          />
          <label className="coursework-progress-interactive-label">
            Complete
          </label>
        </div>
      </div>
    </>
  );
};

export default CourseworkProgress;
