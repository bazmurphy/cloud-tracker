export interface Trainee {
  trainee_id: number;
  first_name: string;
  last_name: string;
}

export interface Week {
  week_id: number;
  week_number: number;
}

export interface Coursework {
  coursework_id: number;
  week_id: number;
  description: string;
}

export interface TraineeCoursework {
  trainee_id: number;
  coursework_id: number;
  in_progress: boolean;
  need_help: boolean;
  completed: boolean;
}

export interface UpdateTraineeCourseworkRequestBody {
  in_progress: boolean;
  need_help: boolean;
  completed: boolean;
}

export interface SuccessReponse<T> {
  success: true;
  error: false;
  payload: T;
}

export interface FailureResponse {
  success: false;
  error: true;
  message: string;
}
