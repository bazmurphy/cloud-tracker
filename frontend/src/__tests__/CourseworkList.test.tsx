import { render, screen } from "@testing-library/react";
import { vi } from "vitest";
import CourseworkList from "../components/CourseworkList";

describe("CourseworkList", () => {
  test("displays loading when loading", () => {
    render(<CourseworkList />);

    expect(screen.getByText(/loading/i)).toBeInTheDocument();
  });

  test("displays an error if it fails to fetch the data", async () => {
    const mockResponse = new Error("Test Mock: Failed To Fetch The Data");

    vi.spyOn(global, "fetch").mockRejectedValueOnce(mockResponse);

    render(<CourseworkList />);

    expect(await screen.findByText(/error/i)).toBeInTheDocument();
  });

  // test("displays coursework cards if data is successfully fetched", async () => {
  //   const mockCourseworksItems = {
  //     success: true,
  //     error: false,
  //     payload: [
  //       {
  //         coursework_id: 1,
  //         week_id: 1,
  //         description: "Week 1.1 : Deploy Frontend to S3",
  //       },
  //       {
  //         coursework_id: 1,
  //         week_id: 2,
  //         description: "Week 1.2 : Deploy Backend to EC2",
  //       },
  //     ],
  //   };

  //   const mockResponse = new Response(JSON.stringify(mockCourseworksItems));
  //   console.log("mockResponse:", mockResponse);

  //   vi.spyOn(global, "fetch").mockResolvedValueOnce(mockResponse);

  //   render(<CourseworkList />);

  //   expect(screen.getByText(/Week 1.1/i)).toBeInTheDocument();
  //   expect(screen.getByText(/Week 1.2/i)).toBeInTheDocument();
  // });
});
