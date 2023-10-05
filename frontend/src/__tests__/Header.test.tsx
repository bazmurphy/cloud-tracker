import { render, screen } from "@testing-library/react";
import Header from "../components/Header";

describe("Header", () => {
  beforeEach(() => {
    render(<Header />);
  });

  test("renders header element", () => {
    const headerTag = screen.getByRole("banner");
    expect(headerTag).toBeInTheDocument();
  });

  test("renders header text", () => {
    const headerText = screen.getByText("Cloud Pathway Tracker");
    expect(headerText).toBeInTheDocument();
  });

  test("renders cloud image", () => {
    const cloudImage = screen.getByAltText("cloud");
    expect(cloudImage).toBeInTheDocument();
  });
});
