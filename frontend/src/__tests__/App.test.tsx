import { render, screen } from "@testing-library/react";
import App from "../App";

describe("App", () => {
  beforeEach(() => {
    render(<App />);
  });

  test("renders main element", () => {
    const mainElement = screen.getByRole("main");
    expect(mainElement).toBeInTheDocument();
  });
});
