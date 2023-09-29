export interface Coursework {
  coursework_id: number;
  week_id: number;
  description: string;
}

export interface CourseworkCardProps {
  courseworkItem: Coursework;
}

export interface Trainee {
  trainee_id: number;
  first_name: string;
  last_name: string;
}

export interface CourseworkProgressProps {
  courseworkId: Coursework["coursework_id"];
  traineeId: Trainee["trainee_id"];
}

export interface TraineeCoursework {
  trainee_id: number;
  coursework_id: number;
  in_progress: boolean;
  need_help: boolean;
  completed: boolean;
}

export interface TraineeContainerProps {
  trainee: Trainee;
  courseworkId: Coursework["coursework_id"];
}

export interface ErrorProps {
  error: Error;
  setRetry: React.Dispatch<React.SetStateAction<boolean>>;
}
