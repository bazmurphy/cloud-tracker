import "./CourseworkList.css";
import { Coursework } from "../types/types";
import { useEffect, useState } from "react";
import CourseworkCard from "./CourseworkCard";
import Loading from "./Loading";
import Error from "./Error";

const CourseworkList = () => {
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  const [retry, setRetry] = useState(false);

  const [coursework, setCoursework] = useState<Coursework[]>([]);

  const fetchCoursework = async () => {
    try {
      setIsLoading(true);
      setError(null);

      const response = await fetch(`/api/coursework`);
      console.log("fetchCoursework response:", response);

      if (!response.ok) {
        throw response;
      }

      const data = await response.json();
      console.log("fetchCoursework data:", data);

      setCoursework(data.payload);
    } catch (error) {
      console.log("catch block error:", error);
      setError(error as Error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchCoursework();
  }, [retry]);

  return (
    <section className="coursework-list">
      {isLoading && <Loading />}
      {error && <Error error={error} setRetry={setRetry} />}
      {coursework.length > 0 &&
        coursework.map((courseworkItem) => (
          <CourseworkCard
            key={courseworkItem.coursework_id}
            courseworkItem={courseworkItem}
          />
        ))}
    </section>
  );
};

export default CourseworkList;
